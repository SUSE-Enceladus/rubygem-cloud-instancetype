#
# spec file for package rubygem-cloud-instancetype
#
# Copyright (c) 2020 SUSE LLC
#
# All modifications and additions to the file contributed by third parties
# remain the property of their copyright owners, unless otherwise agreed
# upon. The license for this file, and modifications and additions to the
# file, is the same license as for the pristine package itself (unless the
# license for the pristine package is not an Open Source License, in which
# case the license is the MIT License). An "Open Source License" is a
# license that conforms to the Open Source Definition (Version 1.9)
# published by the Open Source Initiative.

# Please submit bugfixes or comments via https://bugs.opensuse.org/
#


Name:           rubygem-cloud-instancetype
Version:        1.1.0
Release:        0
%define mod_name cloud-instancetype
%define mod_full_name %{mod_name}-%{version}
BuildRoot:      %{_tmppath}/%{name}-%{version}-build
BuildRequires:  %{rubygem gem2rpm}
BuildRequires:  %{ruby}
BuildRequires:  ruby-macros >= 5
URL:            https://github.com/suse-enceladus/rubygem-cloud-instancetype
Source:         https://rubygems.org/gems/%{mod_full_name}.gem
Summary:        Describe public cloud instance types
License:        GPL-3.0-only
Group:          Development/Languages/Ruby

%description
Describe public cloud instance types.

%prep

%build

%install
%gem_install \
  --doc-files="LICENSE README.md" \
  -f

%gem_packages

%changelog
