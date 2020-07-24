Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A482022C289
	for <lists+linux-can@lfdr.de>; Fri, 24 Jul 2020 11:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbgGXJph (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 24 Jul 2020 05:45:37 -0400
Received: from relay-b03.edpnet.be ([212.71.1.220]:48485 "EHLO
        relay-b03.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbgGXJph (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 24 Jul 2020 05:45:37 -0400
X-ASG-Debug-ID: 1595583904-0a8818764c26c3190001-ZXuqFv
Received: from zotac.vandijck-laurijssen.be (77.109.122.82.adsl.dyn.edpnet.net [77.109.122.82]) by relay-b03.edpnet.be with ESMTP id dQUi13vTjOJerg9Y; Fri, 24 Jul 2020 11:45:04 +0200 (CEST)
X-Barracuda-Envelope-From: dev.kurt@vandijck-laurijssen.be
X-Barracuda-Effective-Source-IP: 77.109.122.82.adsl.dyn.edpnet.net[77.109.122.82]
X-Barracuda-Apparent-Source-IP: 77.109.122.82
Received: from x1.vandijck-laurijssen.be (x1.vandijck-laurijssen.be [IPv6:fd01::1a1d:eaff:fe02:d339])
        by zotac.vandijck-laurijssen.be (Postfix) with ESMTPSA id EEAD7FB0BEC;
        Fri, 24 Jul 2020 11:45:03 +0200 (CEST)
Date:   Fri, 24 Jul 2020 11:45:02 +0200
From:   Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
To:     =?utf-8?B?U3TDqXBoYW5l?= Grosjean <s.grosjean@peak-system.com>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: Re: About sysfs usage by socket-can drivers
Message-ID: <20200724094502.GB27720@x1.vandijck-laurijssen.be>
X-ASG-Orig-Subj: Re: About sysfs usage by socket-can drivers
Mail-Followup-To: =?utf-8?B?U3TDqXBoYW5l?= Grosjean <s.grosjean@peak-system.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
References: <VI1PR03MB5053B1FB7A45D4243BD1F095D6760@VI1PR03MB5053.eurprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <VI1PR03MB5053B1FB7A45D4243BD1F095D6760@VI1PR03MB5053.eurprd03.prod.outlook.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
X-Barracuda-Connect: 77.109.122.82.adsl.dyn.edpnet.net[77.109.122.82]
X-Barracuda-Start-Time: 1595583904
X-Barracuda-URL: https://212.71.1.220:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 545
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: SPAM GLOBAL 0.9837 1.0000 4.1546
X-Barracuda-Spam-Score: 4.15
X-Barracuda-Spam-Status: No, SCORE=4.15 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.83424
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

> We've several pending requests regarding:
> - changing the default clock value,
> - reading the bus load value,
> - using a flashed device id. to better control the can interface number,
> - identifying the (USB) channel
> - ...

I tend to look in the (in your case) usb device, and add properties there.
After all, those are device-related properties, not?

You could reach them via /sys/class/net/canX/device/...

If you add them before the netdev is registered, you can use them in
udev rules without race conditions.

Kurt
