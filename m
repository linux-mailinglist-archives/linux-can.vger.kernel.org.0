Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 960DC2A10C1
	for <lists+linux-can@lfdr.de>; Fri, 30 Oct 2020 23:21:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725791AbgJ3WU7 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 30 Oct 2020 18:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgJ3WU7 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 30 Oct 2020 18:20:59 -0400
Received: from relay.felk.cvut.cz (relay.felk.cvut.cz [IPv6:2001:718:2:1611:0:1:0:70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CAC41C0613D5;
        Fri, 30 Oct 2020 15:20:58 -0700 (PDT)
Received: from cmp.felk.cvut.cz (haar.felk.cvut.cz [147.32.84.19])
        by relay.felk.cvut.cz (8.15.2/8.15.2) with ESMTP id 09UMJbgL034239;
        Fri, 30 Oct 2020 23:19:37 +0100 (CET)
        (envelope-from pisa@cmp.felk.cvut.cz)
Received: from haar.felk.cvut.cz (localhost [127.0.0.1])
        by cmp.felk.cvut.cz (8.14.0/8.12.3/SuSE Linux 0.6) with ESMTP id 09UMJaY6018402;
        Fri, 30 Oct 2020 23:19:36 +0100
Received: (from pisa@localhost)
        by haar.felk.cvut.cz (8.14.0/8.13.7/Submit) id 09UMJa47018401;
        Fri, 30 Oct 2020 23:19:36 +0100
From:   Pavel Pisa <pisa@cmp.felk.cvut.cz>
To:     linux-can@vger.kernel.org, devicetree@vger.kernel.org,
        "Marc Kleine-Budde" <mkl@pengutronix.de>,
        Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        David Miller <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>, mark.rutland@arm.com,
        Carsten Emde <c.emde@osadl.org>, armbru@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marin Jerabek <martin.jerabek01@gmail.com>,
        Ondrej Ille <ondrej.ille@gmail.com>,
        Jiri Novak <jnovak@fel.cvut.cz>,
        Jaroslav Beran <jara.beran@gmail.com>,
        Petr Porazil <porazil@pikron.com>, Pavel Machek <pavel@ucw.cz>,
        Drew Fustini <pdp7pdp7@gmail.com>,
        Pavel Pisa <pisa@cmp.felk.cvut.cz>
Subject: [PATCH v7 0/6] CTU CAN FD open-source IP core SocketCAN driver, PCI, platform integration and documentation
Date:   Fri, 30 Oct 2020 23:19:22 +0100
Message-Id: <cover.1604095004.git.pisa@cmp.felk.cvut.cz>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-FELK-MailScanner-Information: 
X-MailScanner-ID: 09UMJbgL034239
X-FELK-MailScanner: Found to be clean
X-FELK-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
        score=-0.222, required 6, BAYES_00 -0.50, KHOP_HELO_FCRDNS 0.28,
        SPF_HELO_NONE 0.00, SPF_NONE 0.00)
X-FELK-MailScanner-From: pisa@cmp.felk.cvut.cz
X-FELK-MailScanner-Watermark: 1604701179.57925@b26cNcq8EiBSu8Ihnt/U2w
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This driver adds support for the CTU CAN FD open-source IP core.
More documentation and core sources at project page
(https://gitlab.fel.cvut.cz/canbus/ctucanfd_ip_core).
The core integration to Xilinx Zynq system as platform driver
is available (https://gitlab.fel.cvut.cz/canbus/zynq/zynq-can-sja1000-top).
Implementation on Intel FPGA based PCI Express board is available
from project (https://gitlab.fel.cvut.cz/canbus/pcie-ctucanfd).
The CTU CAN FD core emulation send for review for QEMU mainline.
Development repository for QEMU emulation - ctu-canfd branch of
  https://gitlab.fel.cvut.cz/canbus/qemu-canbus

More about CAN bus related projects used and developed at CTU FEE
on the guidepost page http://canbus.pages.fel.cvut.cz/ .

Martin Jerabek (1):
  can: ctucanfd: add support for CTU CAN FD open-source IP core - bus
    independent part.

Pavel Pisa (5):
  dt-bindings: vendor-prefix: add prefix for the Czech Technical
    University in Prague.
  dt-bindings: net: can: binding for CTU CAN FD open-source IP core.
  can: ctucanfd: CTU CAN FD open-source IP core - PCI bus support.
  can: ctucanfd: CTU CAN FD open-source IP core - platform/SoC support.
  docs: ctucanfd: CTU CAN FD open-source IP core documentation.

The version 7 changes:
  - sent at 2020-10-31
  - In response of Pavel Machek review, renamed files to match
    directly module names. The core specification updated
    to provide better description and match of the fields.
    Driver headers, routines adjusted etc..  To achieve this,
    registers HDL was regenerated and  and its connection updated.
  - CAN_STATE_* translation to text has been made robust to
    Linux kernel define value changes/updates and the function
    which uses table has moved after table for better readability.
  - fsm_txt_buffer_user.svg redrawn from scratch to reduce
    file to 16 kB.
  - documentation updated, unified references to recently renamed
    pcie-ctucanfd
  - I have tried to fullfill request to cross-reference SocketCAN
    document by :doc: or :ref: constructs in Sphinx way,
    but without success. I reference geerated HTML on kernel.org
    site for now.

The version 6 changes:
  - sent at 2020-10-22
  - the driver has been tested with 5.9 bigendian MIPS kernel
    against QEMU CTU CAN FD model and correct behavior on PCIe
    virtual board for big-endian system passed
  - documentation updated to reflect inclusion of SocketCAN FD
    and CTU CAN FD functional model support into QEMU mainline
  - the integration for Cyclone V 5CSEMA4U23C6 based DE0-Nano-SoC
    Terasic board used for SkodaAuto research projects at our
    university has been clean up by its author (Jaroslav Beran)
    and published
    https://gitlab.fel.cvut.cz/canbus/intel-soc-ctucanfd
  - Xilinx Zynq Microzed MZ_APO based target for automatic test
    updated to Debian 10 base.

The version 5 changes:
  - sent at 2020-08-15
  - correct Kconfig formatting according to Randy Dunlap
  - silence warnings reported by make W=1 C=1 flags.
    Changes suggested by Jakub Kicinski
  - big thanks for core patch review by Pavel Machek
    resulting in more readability and formating updates
  - fix power management errors found by Pavel Machek
  - removed comments from d-t bindings as suggested by Rob Herring
  - selected ctu,ctucanfd-2 as alternative name to ctu,ctucanfd
    which allows to bind to actual major HDL core sources version 2.x
    if for some reason driver adaptation would not work on version
    read from the core
  - line length limit relaxed to 100 characters on some cases
    where it helps to readability

The version 4 changes:
  - sent at 2020-08-04
  - changes summary, 169 non-merge commits, 6 driver,
    32 IP core sources enhancements and fixes, 58 tests
    in master and about additional 30 iso-testbench
    preparation branch.
  - convert device-tree binding documentation to YAML
  - QEMU model of CTU CAN FD IP core and generic extension
    of QEMU CAN bus emulation developed by Jan Charvat.
  - driver tested on QEMU emulated Malta big-endian MIPS
    platform and big endian-support fixed.
  - checkpatch from 5.4 kernel used to cleanup driver formatting
  - header files generated from IP core IP-Xact description
    updated to include protocol exception (pex) field.
    Mechanism to set it from the driver is not provided yet.

The version 3 changes:
  - sent at 2019-12-21
  - adapts device tree bindings documentation according to
    Rob Herring suggestions.
  - the driver has been separated to individual modules for core support,
    PCI bus integration and platform, SoC integration.
  - the FPGA design has been cleaned up and CAN protocol FSM redesigned
    by Ondrej Ille (the core redesign has been reason to pause attempts to driver
    submission)
  - the work from February 2019 on core, test framework and driver
    1601 commits in total, 436 commits in the core sources, 144 commits
    in the driver, 151 documentation, 502 in tests.
  - not all continuous integration tests updated for latest design version yet
    https://gitlab.fel.cvut.cz/canbus/ctucanfd_ip_core/pipelines
  - Zynq hardware in the loop test show no issues for after driver PCI and platform
    separation and latest VHDL sources updates.
  - driver code has been periodically tested on 4.18.5-rt3 and 4.19 long term
    stable kernels.
  - test of the patches before submission is run on 5.4 kernel
  - the core has been integrated by Jaroslav Beran <jara.beran@gmail.com>
    into Intel FPGA based SoC used in the tester developed for Skoda auto
    at Department of Measurement, Faculty of Electrical Engineering,
    Czech Technical University https://meas.fel.cvut.cz/ . He has contributed
    feedback and fixes to the project.

The version 2 sent at 2019-02-27

The version 1 sent at 2019-02-22

Ondrej Ille has prepared the CTU CAN IP Core sources for new release.
We are waiting with it for the driver review, our intention
is to release IP when driver is reviewed and mainlined.

DKMS CTU CAN FD driver build by OpenBuildService to ease integration
into Debian systems when driver is not provided by the distribution

https://build.opensuse.org/package/show/home:ppisa/ctu_can_fd

Jan Charvat <charvj10@fel.cvut.cz> finished work to extend already
mainlined QEMU SJA1000 and SocketCAN support to provide even CAN FD
support and CTU CAN FD core support.

  https://gitlab.fel.cvut.cz/canbus/qemu-canbus/-/tree/ctu-canfd

The patches has been sent for review to QEMU mainlining list.

Thanks in advance to all who help us to deliver the project into public.

Thanks to all colleagues, reviewers and other providing feedback,
infrastructure and enthusiasm and motivation for open-source work.

Build infrastructure and hardware is provided by
  Department of Control Engineering,
  Faculty of Electrical Engineering,
  Czech Technical University in Prague
  https://dce.fel.cvut.cz/en

 .../bindings/net/can/ctu,ctucanfd.yaml        |   63 +
 .../devicetree/bindings/vendor-prefixes.yaml  |    2 +
 .../device_drivers/ctu/ctucanfd-driver.rst    |  638 +++++++++
 .../ctu/fsm_txt_buffer_user.svg               |  151 +++
 drivers/net/can/Kconfig                       |    1 +
 drivers/net/can/Makefile                      |    1 +
 drivers/net/can/ctucanfd/Kconfig              |   34 +
 drivers/net/can/ctucanfd/Makefile             |   10 +
 drivers/net/can/ctucanfd/ctucanfd.h           |   87 ++
 drivers/net/can/ctucanfd/ctucanfd_base.c      | 1142 +++++++++++++++++
 drivers/net/can/ctucanfd/ctucanfd_frame.h     |  189 +++
 drivers/net/can/ctucanfd/ctucanfd_hw.c        |  751 +++++++++++
 drivers/net/can/ctucanfd/ctucanfd_hw.h        |  935 ++++++++++++++
 drivers/net/can/ctucanfd/ctucanfd_pci.c       |  316 +++++
 drivers/net/can/ctucanfd/ctucanfd_platform.c  |  142 ++
 drivers/net/can/ctucanfd/ctucanfd_regs.h      |  971 ++++++++++++++
 16 files changed, 5433 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/can/ctu,ctucanfd.yaml
 create mode 100644 Documentation/networking/device_drivers/ctu/ctucanfd-driver.rst
 create mode 100644 Documentation/networking/device_drivers/ctu/fsm_txt_buffer_user.svg
 create mode 100644 drivers/net/can/ctucanfd/Kconfig
 create mode 100644 drivers/net/can/ctucanfd/Makefile
 create mode 100644 drivers/net/can/ctucanfd/ctucanfd.h
 create mode 100644 drivers/net/can/ctucanfd/ctucanfd_base.c
 create mode 100644 drivers/net/can/ctucanfd/ctucanfd_frame.h
 create mode 100644 drivers/net/can/ctucanfd/ctucanfd_hw.c
 create mode 100644 drivers/net/can/ctucanfd/ctucanfd_hw.h
 create mode 100644 drivers/net/can/ctucanfd/ctucanfd_pci.c
 create mode 100644 drivers/net/can/ctucanfd/ctucanfd_platform.c
 create mode 100644 drivers/net/can/ctucanfd/ctucanfd_regs.h

-- 
2.20.1

