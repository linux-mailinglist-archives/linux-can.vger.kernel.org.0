Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A12A49396A
	for <lists+linux-can@lfdr.de>; Wed, 19 Jan 2022 12:21:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354115AbiASLUx (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 19 Jan 2022 06:20:53 -0500
Received: from mailgw.felk.cvut.cz ([147.32.82.15]:52092 "EHLO
        mailgw.felk.cvut.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353966AbiASLUu (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 19 Jan 2022 06:20:50 -0500
X-Greylist: delayed 350 seconds by postgrey-1.27 at vger.kernel.org; Wed, 19 Jan 2022 06:20:50 EST
Received: from mailgw.felk.cvut.cz (localhost.localdomain [127.0.0.1])
        by mailgw.felk.cvut.cz (Proxmox) with ESMTP id B4EF530B035C;
        Wed, 19 Jan 2022 12:14:55 +0100 (CET)
Received: from cmp.felk.cvut.cz (haar.felk.cvut.cz [147.32.84.19])
        by mailgw.felk.cvut.cz (Proxmox) with ESMTPS id 9DCB330ADE4A;
        Wed, 19 Jan 2022 12:14:54 +0100 (CET)
Received: from haar.felk.cvut.cz (localhost [127.0.0.1])
        by cmp.felk.cvut.cz (8.14.0/8.12.3/SuSE Linux 0.6) with ESMTP id 20JBEs2j015354;
        Wed, 19 Jan 2022 12:14:54 +0100
Received: (from pisa@localhost)
        by haar.felk.cvut.cz (8.14.0/8.13.7/Submit) id 20JBEss6015353;
        Wed, 19 Jan 2022 12:14:54 +0100
X-Authentication-Warning: haar.felk.cvut.cz: pisa set sender to pisa@fel.cvut.cz using -f
From:   Pavel Pisa <pisa@fel.cvut.cz>
To:     sukreet.pal@st.ovgu.de, QEMU Developers <qemu-devel@nongnu.org>,
        linux-can@vger.kernel.org
Subject: Re: QEMU CAN-FD emulation
Date:   Wed, 19 Jan 2022 12:14:53 +0100
User-Agent: KMail/1.9.10
References: <20220117143713.Horde.leGGFb7yZC3uaqrqolZYIBE@webmailer.ovgu.de> <202201181142.49569.pisa@fel.cvut.cz> <20220118114135.Horde.3Jm5PugNZVY8j2cNC8vRLl1@webmailer.ovgu.de>
In-Reply-To: <20220118114135.Horde.3Jm5PugNZVY8j2cNC8vRLl1@webmailer.ovgu.de>
X-KMail-QuotePrefix: > 
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <202201191214.53610.pisa@fel.cvut.cz>
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Dear Sukreet Pal,

On Tuesday 18 of January 2022 12:41:35 sukreet.pal@st.ovgu.de wrote:
> Yes, we can push the conversation in qemu mailing list.

Great, may be there is some other input from the list.

Recapitulation:

Sukreet Pal want to use CAN emulation included
in QEMU to test some CAN related software build
for ARM. At this moment, CAN emulation
is available for systems which are equipped by PCI
and for some platform devices on Xilinx

  https://github.com/qemu/qemu/blob/stable-6.1/docs/can.txt

For generic ARM system PCI and SJA1000 driver should
be usable out of the box when appropriate kernel is used.
When I have developed with my students and test and maintain
CAN (SJA1000 and CTU CAN FD) emulation support I use
combination of ARM1176 and VersatilePB for testing.

This setup works for me

Host side (laptop with Debian and without real CAN hardware)

  modprobe can-raw
  modprobe vcan
  ip link add dev can0 type vcan
  ip link set can0 up

The QEMU invoked

qemu-system-arm -cpu arm1176 -m 256 -M versatilepb \
      -kernel kernel-qemu-arm1176-versatilepb \
      -initrd ramdisk.cpio \
      -hda rpi-wheezy-overlay \
      -append "root=/dev/ram console=ttyAMA0" \
      -object can-bus,id=canbus0 \
      -object can-host-socketcan,if=can0,canbus=canbus0,id=canbus0-socketcan \
      -device kvaser_pci,canbus=canbus0 \
      -virtfs local,path=shareddir,security_model=none,mount_tag=shareddir \
      -nographic \

I have some own minimal busybox based initial ramdisk to test QEMU
and kernel from it.

On Monday 17 of January 2022 17:31:32 Pavel Pisa wrote:
> If you can reach shell prompt in the target system
> you should check that Kvaser CAN controller is seen
> on PCI bus.
>
> Try
>
>   lspci -nn
>
> You should see there 10e8:8406. If you do not have lspci
> availabel in the target system, then try
>
>   cat /proc/bus/pci/devices
>
> There should be line
>
>   00xx    10e88406        5e                  1401                    1481
>
> Check that your ARM kernel build includes kvaser_pci driver
> as built in or as the module. I have it as a module.
>
> So my lsmod list
>
>   Module                  Size  Used by    Not tainted
>   kvaser_pci              2332  0
>   sja1000                 6023  1 kvaser_pci
>   can_raw                 6112  0
>   can_dev                 8289  1 sja1000
>   can                    26342  1 can_raw
>   ...

On Tuesday 18 of January 2022 11:08:32 sukreet.pal@st.ovgu.de wrote:
> # lspci -nn
> 00:0c.0 Class 0100: 1000:0012
>
> / # cat /proc/bus/pci/devices
> 0060	10000012	5d	            1001	        50002000	        50000000
>              0	               0	               0	               0
>          100	             400	            2000	               0
>          0	               0	               0	sym53c8xx
>

So it seems that device is not visible on the PCI bus by the kernel.

Suggestion to list QEMU PCI bus devices from QEMU monitor

On Tuesday 18 of January 2022 11:42:49 Pavel Pisa wrote:
> For QEMU monitor access see
>  
> 
https://serverfault.com/questions/587189/how-to-list-all-devices-emulated-in-a-qemu-virtual-machine
>
> Use
>
>   info pci
>
> You should see in the list
>
>     Bus  0, device  XX, function 0:
>     Class 65280: PCI device 10e8:8406
>       PCI subsystem 1af4:1100
>       IRQ 94, pin A
>       BAR0: I/O at 0x1400 [0x147f].
>       BAR1: I/O at 0x1480 [0x14ff].
>       BAR2: I/O at 0x1820 [0x1827].
>       id ""
>
> If this is not in the list then kernel cannot see the device either.

On Tuesday 18 of January 2022 12:41:35 sukreet.pal@st.ovgu.de wrote:
> (qemu) info pci
>    Bus  0, device  11, function 0:
>      Class 2880: PCI device 10ee:0300
>        PCI subsystem 1af4:1100
>        id ""
>    Bus  0, device  12, function 0:
>      SCSI controller: PCI device 1000:0012
>        PCI subsystem 0000:1000
>        IRQ 93.
>        BAR0: I/O at 0x1000 [0x10ff].
>        BAR1: 32 bit memory at 0x50002000 [0x500023ff].
>        BAR2: 32 bit memory at 0x50000000 [0x50001fff].
>        id ""
>    Bus  0, device  13, function 0:
>      Class 65280: PCI device 10e8:8406
>        PCI subsystem 1af4:1100
>        IRQ 94.
>        BAR0: I/O at 0xffffffffffffffff [0x007e].
>        BAR1: I/O at 0xffffffffffffffff [0x007e].
>        BAR2: I/O at 0xffffffffffffffff [0x0006].
>        id ""
>
> I think the kernal can see the devices.

It seems that QEMU report device on the bus but
the kernel does not list device in /proc/bus/pci/devices

> > What is version of your QEMU?
>
> QEMU emulator version 4.2.1 (Debian 1:4.2-3ubuntu6.19)
> Copyright (c) 2003-2019 Fabrice Bellard and the QEMU Project
> developers (it's the default ubuntu 20.04 qemu version)

In my development repo the last used is

QEMU emulator version 6.0.91 (v6.1.0-rc1-3-g1560ab766e)
Copyright (c) 2003-2021 Fabrice Bellard and the QEMU Project developers

But I have retested with Debian old stable distribution
version

QEMU emulator version 3.1.0 (Debian 1:3.1+dfsg-8+deb10u8)
Copyright (c) 2003-2018 Fabrice Bellard and the QEMU Project developers

and emulation works.

On the report it is strange that device is not seen in the kernel
proc list. It is independent of driver availability.

The strange is even BAR report
  BAR0: I/O at 0xffffffffffffffff [0x007e].  ...
Mine
  BAR0: I/O at 0x1400 [0x147f]. ...

But I expect that BAR FFF value is caused by
unconfigured address. Strange is that the last
bit in the bracket is 0. The BAR fixed
part should respect that it is IO device.

I have seen some warning that PCI I/O devices
mapping is not supported/emulated on VersatilePB.
I have no problems with Kvaser emulation on that
platform with all tested QEMU builds from I think
2.x days.

Test of the other actually supported SJA1000 devices
would not help probably because mioe3680 and pcm3680
are also I/O mapped.

Option is to test our CTU CAN FD which is memory
region mapped

 -device ctucan_pci,canbus0=canbus0-bus,canbus1=canbus0-bus

But t is necessary to build driver for given kernel.
It is available in the repo and has been recently
updated to the required style  

  https://gitlab.fel.cvut.cz/canbus/ctucanfd_ip_core

(I hope to find time and help for mainlining soon).

Best wishes,

                Pavel Pisa
    phone:      +420 603531357
    e-mail:     pisa@cmp.felk.cvut.cz
    Department of Control Engineering FEE CVUT
    Karlovo namesti 13, 121 35, Prague 2
    university: http://dce.fel.cvut.cz/
    personal:   http://cmp.felk.cvut.cz/~pisa
    projects:   https://www.openhub.net/accounts/ppisa
    CAN related:http://canbus.pages.fel.cvut.cz/
    Open Technologies Research Education and Exchange Services
    https://gitlab.fel.cvut.cz/otrees/org/-/wikis/home

