Puppet::Type.newtype(:printer) do
  @doc = "Manage installed printers and printer queues on a puppet node."

  ensurable

  newparam(:name, :isnamevar => true) do
    desc "The name of the printer, any character except SPACE, TAB, / or #, Not case sensitive"

    validate do |value|
      raise ArgumentError, "%s is not a valid printer name" % value if value =~ /[\s\t\/#]/
    end
  end

  newproperty(:uri) do
    desc "Sets the device-uri attribute of the printer destination."
  end

  newproperty(:description) do
    desc "Provides a textual description of the destination."
  end

  newproperty(:location) do
    desc "Provides a textual location of the destination."
  end

  # NOTE: model and ppd are parameters because they cannot be idempotent. CUPS will copy and rename the ppd
  # upon printer creation (on mac os x at least), therefore: you can only change the model/ppd when the printer is
  # created.
  newparam(:model) do
    desc "Sets a standard System V interface script or PPD file for the printer from the model directory.

    Use the -m option with the lpinfo(8) command to get a list of supported models.
    "
  end

  newparam(:ppd) do
    desc "Specifies a PostScript Printer Description file to use with the printer."
  end

  newparam(:interface) do
    desc "Specifies a System V interface file to use with the printer."
  end

  newproperty(:enabled) do
    desc "Enables the destination and accepts jobs"

    newvalues(:true, :false)
    defaultto :true
  end

  newproperty(:accept) do
    desc "Specifies whether the destination will accept jobs, or reject them."

    newvalues(:true, :false)
    defaultto :true
  end

  newparam(:shared) do
    desc "Sets the destination to shared/published or unshared/unpublished."

    newvalues(:true, :false)
    defaultto :false
  end

  newproperty(:options) do
    desc "Sets a list of options for the printer"

    validate do |value|
      raise ArgumentError, "invalid value supplied for printer options" unless value.is_a? Hash
    end
  end

  newproperty(:ppd_options) do
    desc "Sets a list of PPD (vendor specific) options for the printer.

    Use lpoptions -p destination -l to get a list of valid vendor PPD options for that queue."

    validate do |value|
      raise ArgumentError, "invalid value supplied for printer PPD options" unless value.is_a? Hash
    end
  end

  # Allow a printer resource without explicitly specifying a file resource for the PPD.
  autorequire(:file) do
     self[:ppd] if self[:ppd]
  end
end
