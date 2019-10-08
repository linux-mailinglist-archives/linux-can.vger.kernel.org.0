Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF25CF6F7
	for <lists+linux-can@lfdr.de>; Tue,  8 Oct 2019 12:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730016AbfJHKYI (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 8 Oct 2019 06:24:08 -0400
Received: from relay-b02.edpnet.be ([212.71.1.222]:51493 "EHLO
        relay-b02.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729958AbfJHKYI (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 8 Oct 2019 06:24:08 -0400
X-ASG-Debug-ID: 1570530245-0a7b8d13c0e0f10001-ZXuqFv
Received: from zotac.vandijck-laurijssen.be (77.109.105.74.adsl.dyn.edpnet.net [77.109.105.74]) by relay-b02.edpnet.be with ESMTP id KY2HUiCwHjfMZi64; Tue, 08 Oct 2019 12:24:05 +0200 (CEST)
X-Barracuda-Envelope-From: dev.kurt@vandijck-laurijssen.be
X-Barracuda-Effective-Source-IP: 77.109.105.74.adsl.dyn.edpnet.net[77.109.105.74]
X-Barracuda-Apparent-Source-IP: 77.109.105.74
Received: from x1.vandijck-laurijssen.be (74.250-240-81.adsl-static.isp.belgacom.be [81.240.250.74])
        by zotac.vandijck-laurijssen.be (Postfix) with ESMTPSA id D5E96A47984;
        Tue,  8 Oct 2019 12:24:04 +0200 (CEST)
Date:   Tue, 8 Oct 2019 12:24:03 +0200
From:   Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org,
        Joe Burmeister <joe.burmeister@devtank.co.uk>,
        Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH v2] can: c_can: c_can_poll(): only read status register
 after status IRQ
Message-ID: <20191008102403.GA21036@x1.vandijck-laurijssen.be>
X-ASG-Orig-Subj: Re: [PATCH v2] can: c_can: c_can_poll(): only read status register
 after status IRQ
Mail-Followup-To: Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-can@vger.kernel.org,
        Joe Burmeister <joe.burmeister@devtank.co.uk>,
        Wolfgang Grandegger <wg@grandegger.com>
References: <20191008095707.23902-1-mkl@pengutronix.de>
 <d9211654-8b60-d0a1-31fa-c922f9cbc23a@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d9211654-8b60-d0a1-31fa-c922f9cbc23a@pengutronix.de>
User-Agent: Mutt/1.5.22 (2013-10-16)
X-Barracuda-Connect: 77.109.105.74.adsl.dyn.edpnet.net[77.109.105.74]
X-Barracuda-Start-Time: 1570530245
X-Barracuda-URL: https://212.71.1.222:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 1254
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.7674 1.0000 1.9242
X-Barracuda-Spam-Score: 1.92
X-Barracuda-Spam-Status: No, SCORE=1.92 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.77213
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On di, 08 okt 2019 12:02:15 +0200, Marc Kleine-Budde wrote:
> On 10/8/19 11:57 AM, Marc Kleine-Budde wrote:
> > From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
> > 
> > When the status register is read without status IRQ pending, it may get
> > into a state that it goes into busoff state without having its irq
> > activated, so the driver will never know.
> 
> Can you help rephrasing the patch description.
> 
> I understand the problem is that we should only read the status register
> if there is a status IRQ. But what are the consequences regarding the
> busoff state?

busoff is the last irq you'll get :-)
If you miss that one, you'll never catch in again.

The observation is that you have some bus errors, but the driver doesn't
know that the chip went in busoff, so it will never wake up again.

Only solution is to set link down & up again.

What's your opinion about this one:

When the status register is read without the status IRQ pending, the
chip may not raise the interrupt line for an upcoming status interrupt
and the driver may miss a status interrupt.
It is critical that the BUSOFF status interrupt is informed to the
higher layers, since no more interrupts will follow without
intervention.
