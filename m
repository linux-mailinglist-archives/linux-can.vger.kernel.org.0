Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA2834E1FC
	for <lists+linux-can@lfdr.de>; Tue, 30 Mar 2021 09:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbhC3HUG (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 30 Mar 2021 03:20:06 -0400
Received: from mail.rdts.de ([195.243.153.28]:36792 "EHLO mail.rdts.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229483AbhC3HT5 (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Tue, 30 Mar 2021 03:19:57 -0400
X-Greylist: delayed 583 seconds by postgrey-1.27 at vger.kernel.org; Tue, 30 Mar 2021 03:19:57 EDT
Received: from webmail.rdts.de (php1.rdts.de [82.223.13.20])
        by mail.rdts.de (Postfix) with ESMTPSA id 084D3A0F55
        for <linux-can@vger.kernel.org>; Tue, 30 Mar 2021 09:10:10 +0200 (CEST)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 30 Mar 2021 09:10:10 +0200
From:   Gerhard Bertelsmann <info@gerhard-bertelsmann.de>
To:     linux-can@vger.kernel.org
Subject: [mcp251x] Using MCP2515 with half duplex driver fails on init
Message-ID: <7cc4e81bdafd61649ac2b3f628083bd1@gerhard-bertelsmann.de>
X-Sender: info@gerhard-bertelsmann.de
User-Agent: Roundcube Webmail/1.2.3
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi,

I'm trying to get a MCP2515 working with an OpenWRT router connected to 
the
second SPI channel (CS1). The first one is used by the flash. Here the 
error
message while loading the mcp251x module (Kernel 5.10.26):

[  112.226164] mcp251x spi0.1: spi transfer failed: ret = -22
[  112.231810] mcp251x spi0.1: Probe failed, err=22
[  112.237021] mcp251x: probe of spi0.1 failed with error -22

The DTS part looks like:

/ {
         compatible = "onion,omega2", "mediatek,mt7628an-soc";
};
...
&spi0 {
         status = "okay";

         pinctrl-names = "default";
         pinctrl-0 = <&spi_pins>, <&spi_cs1_pins>;

         flash@0 {
                 compatible = "jedec,spi-nor";
                 reg = <0>;
                 spi-max-frequency = <40000000>;
                 ...
         };
         can0: can@1 {
                 compatible = "microchip,mcp2515";
                 reg = <1>;
                 clock-frequency = <8000000>;
                 interrupt-parent = <&gpio>;
                 interrupts = <16 8>;
                 spi-max-frequency = <10000000>;
         };
};

I don't see any activity on the SPI bus/CS1 line. A cross check with 
spidev
using following DTS sequence instead of can0:

         spidev@1 {
                 #address-cells = <1>;
                 #size-cells = <1>;
                 compatible = "rohm,dh2228fv";
                 reg = <1>;
                 spi-max-frequency = <100000>;
         };

shows, that the setup using SPI bus with CS1 is working.

Of course, sharing the SPI bus with the flash isn't the best performance
practice, but it should be ok because when the programms are loaded, 
it's
unlikely that the SPI bus is occupied by the routers flash system 
anymore.

Does anybody have a hint why the init fails ?

Regards

Gerd
