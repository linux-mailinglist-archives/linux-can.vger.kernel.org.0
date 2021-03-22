Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66D0A343BF6
	for <lists+linux-can@lfdr.de>; Mon, 22 Mar 2021 09:41:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbhCVIlR (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 22 Mar 2021 04:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbhCVIk5 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 22 Mar 2021 04:40:57 -0400
X-Greylist: delayed 1970 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 22 Mar 2021 01:40:48 PDT
Received: from relay.felk.cvut.cz (relay.felk.cvut.cz [IPv6:2001:718:2:1611:0:1:0:70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 65EA1C061574
        for <linux-can@vger.kernel.org>; Mon, 22 Mar 2021 01:40:48 -0700 (PDT)
Received: from cmp.felk.cvut.cz (haar.felk.cvut.cz [147.32.84.19])
        by relay.felk.cvut.cz (8.15.2/8.15.2) with ESMTP id 12M86si5001238;
        Mon, 22 Mar 2021 09:06:54 +0100 (CET)
        (envelope-from pisa@cmp.felk.cvut.cz)
Received: from haar.felk.cvut.cz (localhost [127.0.0.1])
        by cmp.felk.cvut.cz (8.14.0/8.12.3/SuSE Linux 0.6) with ESMTP id 12M86sJC017883;
        Mon, 22 Mar 2021 09:06:54 +0100
Received: (from pisa@localhost)
        by haar.felk.cvut.cz (8.14.0/8.13.7/Submit) id 12M86rhS017876;
        Mon, 22 Mar 2021 09:06:53 +0100
X-Authentication-Warning: haar.felk.cvut.cz: pisa set sender to pisa@cmp.felk.cvut.cz using -f
From:   Pavel Pisa <pisa@cmp.felk.cvut.cz>
To:     linux-can@vger.kernel.org
Subject: CAN FD controllers (M-CAN tcan4x5x as well as Microchip mcp251xfd) fails on iMX6 eCSPI interface
Date:   Mon, 22 Mar 2021 09:06:52 +0100
User-Agent: KMail/1.9.10
Cc:     "Marc Kleine-Budde" <mkl@pengutronix.de>,
        Petr Porazil <porazil@volny.cz>, Han Xu <han.xu@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Tiago Brusamarello <tiago.brusamarello@datacom.ind.br>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <202103220906.52896.pisa@cmp.felk.cvut.cz>
X-FELK-MailScanner-Information: 
X-MailScanner-ID: 12M86si5001238
X-FELK-MailScanner: Found to be clean
X-FELK-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
        score=-0.098, required 6, BAYES_00 -0.50, KHOP_HELO_FCRDNS 0.40,
        SPF_HELO_NONE 0.00, SPF_NONE 0.00, URIBL_BLOCKED 0.00)
X-FELK-MailScanner-From: pisa@cmp.felk.cvut.cz
X-FELK-MailScanner-Watermark: 1617005215.98967@Xe4votM8PDpv5zZA3XHzOg
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello everybody,

my colleague at Elektroline.cz works on design of iMX6
based system with CAN FD support realized by tcan4x5x
chip connected to eCSPI. It seems that there are problems
with eCSPI DMA stucks and other troubles. When the same
chip (or even Microchip's mcp251xfd) is connected to
other (less industry sound platforms) as Allwinner etc...
drivers seems to work reliably, but tests on iMX6 results
in failures. They consider fast redesign to slCAN connected
second Microchip MCU to resolve critical problem for the
project now....

The setup on 5.7 kernel partially wrks

Linux RAPTOR 5.7.8 #2 SMP Fri Oct 30 18:55:02 CET 2020 armv7l GNU/Linux

&ecspi1 {
	pinctrl-names = "default";
	pinctrl-0 = <&pinctrl_raptor_ecspi1>;
	cs-gpios = <&gpio2 30 0> ;
	status = "okay";

	tcan4550: tcan4x5x@0 {
		compatible = "ti,tcan4x5x";
		reg = <0>;
		#address-cells = <1>;
		#size-cells = <1>;
		spi-max-frequency = <16000000>;
		bosch,mram-cfg = <0x0 0 0 32 0 0 1 1>;
		interrupt-parent = <&gpio5>;
		interrupts = <4 GPIO_ACTIVE_LOW>;
		device-wake-gpios = <&gpio2 16 GPIO_ACTIVE_LOW>;
	};
};

Transmit test

cangen can1 -g 5 -I 123 -n100
OK
cangen can1 -g 3 -I 123 -n100
write: No buffer space available
[  857.829179] tcan4x5x spi0.0 can1: hard_xmit called while tx busy
[  857.836124] tcan4x5x spi0.0 can1: hard_xmit called while tx busy
[  857.842537] tcan4x5x spi0.0 can1: hard_xmit called while tx busy
[  857.852634] NOHZ: local_softirq_pending 08
[  857.862952] NOHZ: local_softirq_pending 08

Receive test
cangen can0 -g 5 -I 123 -n100
OK
cangen can0 -g 3 -I 123 -n100
[ 1161.348615] tcan4x5x spi0.0 can1: msg lost in rxf0
[ 1161.355672] tcan4x5x spi0.0 can1: msg lost in rxf0
[ 1161.362845] tcan4x5x spi0.0 can1: msg lost in rxf0
[ 1161.369976] tcan4x5x spi0.0 can1: msg lost in rxf0
[ 1161.377074] tcan4x5x spi0.0 can1: msg lost in rxf0
[ 1161.384021] tcan4x5x spi0.0 can1: msg lost in rxf0
[ 1161.391211] tcan4x5x spi0.0 can1: msg lost in rxf0
[ 1161.398338] tcan4x5x spi0.0 can1: msg lost in rxf0
[ 1161.405299] tcan4x5x spi0.0 can1: msg lost in rxf0
[ 1161.412445] tcan4x5x spi0.0 can1: msg lost in rxf0
[ 1161.419680] tcan4x5x spi0.0 can1: msg lost in rxf0
...

the 5.10 RT (preffered) and non-RT seems to be completely broken 

Linux RAPTOR 5.10.19 #6 SMP Tue Mar 9 13:29:28 CET 2021 armv7l GNU/Linux

&ecspi1 {
	pinctrl-names = "default";
	pinctrl-0 = <&pinctrl_raptor_ecspi1>;
	cs-gpios = <&gpio2 30 0> ;
	status = "okay";

	tcan4550: tcan4x5x@0 {
		compatible = "ti,tcan4x5x";
		reg = <0>;
		#address-cells = <1>;
		#size-cells = <1>;
		spi-max-frequency = <16000000>;
		bosch,mram-cfg = <0x0 0 0 32 0 0 1 1>;
		interrupt-parent = <&gpio5>;
		interrupts = <4 GPIO_ACTIVE_LOW>;
		device-wake-gpios = <&gpio2 16 GPIO_ACTIVE_LOW>;
	};
};

Transmit test, only one message transmited.

cangen can1 -g 100 -I 123 -n100
write: No buffer space available

candump can0
  can0  123   [8]  06 56 C6 01 AF E3 B6 4A

Receive test no messages received

[  332.449605] tcan4x5x spi0.0 can1: msg lost in rxf0

We can rebuild kernel, test patches, try to investgate what happens.

All suggestions what to test and what can be cause welcomed.

Thanks in advance,

                Pavel
-- 
                Pavel Pisa
    phone:      +420 603531357
    e-mail:     pisa@cmp.felk.cvut.cz
    Department of Control Engineering FEE CVUT
    Karlovo namesti 13, 121 35, Prague 2
    university: http://dce.fel.cvut.cz/
    company:    https://www.pikron.com/
    personal:   http://cmp.felk.cvut.cz/~pisa
    projects:   https://www.openhub.net/accounts/ppisa
    CAN related:http://canbus.pages.fel.cvut.cz/

