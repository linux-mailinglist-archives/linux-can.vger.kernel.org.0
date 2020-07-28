Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F80123088D
	for <lists+linux-can@lfdr.de>; Tue, 28 Jul 2020 13:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729003AbgG1LU1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-can@lfdr.de>); Tue, 28 Jul 2020 07:20:27 -0400
Received: from relay-b02.edpnet.be ([212.71.1.222]:39688 "EHLO
        relay-b02.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728954AbgG1LUW (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 28 Jul 2020 07:20:22 -0400
X-ASG-Debug-ID: 1595935215-0a7b8d18321893a90001-ZXuqFv
Received: from zotac.vandijck-laurijssen.be (77.109.122.82.adsl.dyn.edpnet.net [77.109.122.82]) by relay-b02.edpnet.be with ESMTP id 4BDXYfSG3t3p7Eeq; Tue, 28 Jul 2020 13:20:15 +0200 (CEST)
X-Barracuda-Envelope-From: dev.kurt@vandijck-laurijssen.be
X-Barracuda-Effective-Source-IP: 77.109.122.82.adsl.dyn.edpnet.net[77.109.122.82]
X-Barracuda-Apparent-Source-IP: 77.109.122.82
Received: from [10.44.24.139] (unknown [188.188.88.139])
        by zotac.vandijck-laurijssen.be (Postfix) with ESMTPSA id AC7FDFB99E1;
        Tue, 28 Jul 2020 13:20:14 +0200 (CEST)
Date:   Tue, 28 Jul 2020 13:20:11 +0200
User-Agent: K-9 Mail for Android
In-Reply-To: <VI1PR03MB5053EF45CF182D93B68F3FC4D6730@VI1PR03MB5053.eurprd03.prod.outlook.com>
References: <VI1PR03MB5053B1FB7A45D4243BD1F095D6760@VI1PR03MB5053.eurprd03.prod.outlook.com>,<20200724094502.GB27720@x1.vandijck-laurijssen.be> <VI1PR03MB5053EF45CF182D93B68F3FC4D6730@VI1PR03MB5053.eurprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: RE: About sysfs usage by socket-can drivers
To:     =?ISO-8859-1?Q?St=E9phane_Grosjean?= <s.grosjean@peak-system.com>
X-ASG-Orig-Subj: RE: About sysfs usage by socket-can drivers
CC:     Marc Kleine-Budde <mkl@pengutronix.de>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
From:   Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Message-ID: <5E128BFC-17C1-4671-B243-D6E70C3DD10C@vandijck-laurijssen.be>
X-Barracuda-Connect: 77.109.122.82.adsl.dyn.edpnet.net[77.109.122.82]
X-Barracuda-Start-Time: 1595935215
X-Barracuda-URL: https://212.71.1.222:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 1762
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.5110 1.0000 0.7500
X-Barracuda-Spam-Score: 0.75
X-Barracuda-Spam-Status: No, SCORE=0.75 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.83520
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 28 July 2020 09:31:52 GMT+02:00, "Stéphane Grosjean" <s.grosjean@peak-system.com> wrote:
>Thx for your answer Kurt! Even if properties are channel related, this
>could be a solution...
>
>But... creating a (new) channel tree under /devices looks weird,
>doesn't it?

/sys/class/net/.... are symlinks to /sys/devices/..., not weird IMO

>And why it should be "easier" to add attributes there rather than under
>each /sys/class/net/can?

Equally easy to add, much simpler to use in udev without race conditions.


>
>-- Stéphane
>
>
>De : Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
>Envoyé : vendredi 24 juillet 2020 11:45
>À : Stéphane Grosjean <s.grosjean@peak-system.com>
>Cc : Marc Kleine-Budde <mkl@pengutronix.de>; linux-can@vger.kernel.org
><linux-can@vger.kernel.org>
>Objet : Re: About sysfs usage by socket-can drivers
>
>> We've several pending requests regarding:
>> - changing the default clock value,
>> - reading the bus load value,
>> - using a flashed device id. to better control the can interface
>number,
>> - identifying the (USB) channel
>> - ...
>
>I tend to look in the (in your case) usb device, and add properties
>there.
>After all, those are device-related properties, not?
>
>You could reach them via /sys/class/net/canX/device/...
>
>If you add them before the netdev is registered, you can use them in
>udev rules without race conditions.
>
>Kurt
>
>--
>PEAK-System Technik GmbH
>Sitz der Gesellschaft Darmstadt - HRB 9183
>Geschaeftsfuehrung: Alexander Gach / Uwe Wilhelm
>Unsere Datenschutzerklaerung mit wichtigen Hinweisen
>zur Behandlung personenbezogener Daten finden Sie unter
>www.peak-system.com/Datenschutz.483.0.html

Sent from a small mobile device
