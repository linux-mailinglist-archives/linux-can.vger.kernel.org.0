Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 367182D06E0
	for <lists+linux-can@lfdr.de>; Sun,  6 Dec 2020 20:27:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727605AbgLFT1O (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 6 Dec 2020 14:27:14 -0500
Received: from relay-b03.edpnet.be ([212.71.1.220]:59269 "EHLO
        relay-b03.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbgLFT1N (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 6 Dec 2020 14:27:13 -0500
X-ASG-Debug-ID: 1607282790-0a88181461297800001-ZXuqFv
Received: from zotac.vandijck-laurijssen.be (77.109.124.12.adsl.dyn.edpnet.net [77.109.124.12]) by relay-b03.edpnet.be with ESMTP id 7nTjLU9StOKFdIc0; Sun, 06 Dec 2020 20:26:30 +0100 (CET)
X-Barracuda-Envelope-From: dev.kurt@vandijck-laurijssen.be
X-Barracuda-Effective-Source-IP: 77.109.124.12.adsl.dyn.edpnet.net[77.109.124.12]
X-Barracuda-Apparent-Source-IP: 77.109.124.12
Received: from x1.vandijck-laurijssen.be (x1.vandijck-laurijssen.be [IPv6:fd01::1a1d:eaff:fe02:d339])
        by zotac.vandijck-laurijssen.be (Postfix) with ESMTPSA id 975681184134;
        Sun,  6 Dec 2020 20:26:30 +0100 (CET)
Date:   Sun, 6 Dec 2020 20:26:25 +0100
From:   Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Sven Schuchmann <schuchmann@schleissheimer.de>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: Re: mcp251xfd No Oscillator (clock) defined
Message-ID: <20201206192625.GB15319@x1.vandijck-laurijssen.be>
X-ASG-Orig-Subj: Re: mcp251xfd No Oscillator (clock) defined
Mail-Followup-To: Marc Kleine-Budde <mkl@pengutronix.de>,
        Sven Schuchmann <schuchmann@schleissheimer.de>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
References: <DB8P190MB0634231494D3D788E87DCE54D9CF0@DB8P190MB0634.EURP190.PROD.OUTLOOK.COM>
 <611813e9-943a-33be-4e9b-5cb1397ac5d9@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <611813e9-943a-33be-4e9b-5cb1397ac5d9@pengutronix.de>
User-Agent: Mutt/1.5.22 (2013-10-16)
X-Barracuda-Connect: 77.109.124.12.adsl.dyn.edpnet.net[77.109.124.12]
X-Barracuda-Start-Time: 1607282790
X-Barracuda-URL: https://212.71.1.220:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 511
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: SPAM GLOBAL 1.0000 1.0000 4.3429
X-Barracuda-Spam-Score: 4.34
X-Barracuda-Spam-Status: No, SCORE=4.34 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.86344
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Sun, 06 Dec 2020 11:32:39 +0100, Marc Kleine-Budde wrote:
> On 12/6/20 11:18 AM, Sven Schuchmann wrote:
> > 
> > $ sudo dtoverlay spi0-1cs cs0_pin=24
> > $ sudo dtoverlay mcp251xfd spi0-1 oscillator=40000000 speed=20000000 interrupt=18
> 
> Better add the overlays statically in the bootloader via config.txt:

why is it better in the bootloader than from linux?

I personnaly favor loading overlays from linux, where there are way more
possibilities to determing which overlays to load.

Kurt
