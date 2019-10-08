Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3EDCF6FB
	for <lists+linux-can@lfdr.de>; Tue,  8 Oct 2019 12:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730156AbfJHKZ3 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 8 Oct 2019 06:25:29 -0400
Received: from relay-b03.edpnet.be ([212.71.1.220]:34569 "EHLO
        relay-b03.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730138AbfJHKZ3 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 8 Oct 2019 06:25:29 -0400
X-ASG-Debug-ID: 1570530326-0a88186e2048b50c0001-ZXuqFv
Received: from zotac.vandijck-laurijssen.be (77.109.105.74.adsl.dyn.edpnet.net [77.109.105.74]) by relay-b03.edpnet.be with ESMTP id fH8Ahem3njSRhJH7; Tue, 08 Oct 2019 12:25:26 +0200 (CEST)
X-Barracuda-Envelope-From: dev.kurt@vandijck-laurijssen.be
X-Barracuda-Effective-Source-IP: 77.109.105.74.adsl.dyn.edpnet.net[77.109.105.74]
X-Barracuda-Apparent-Source-IP: 77.109.105.74
Received: from x1.vandijck-laurijssen.be (74.250-240-81.adsl-static.isp.belgacom.be [81.240.250.74])
        by zotac.vandijck-laurijssen.be (Postfix) with ESMTPSA id D4B54A47993;
        Tue,  8 Oct 2019 12:25:25 +0200 (CEST)
Date:   Tue, 8 Oct 2019 12:25:24 +0200
From:   Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org,
        Joe Burmeister <joe.burmeister@devtank.co.uk>,
        Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH v2] can: c_can: c_can_poll(): only read status register
 after status IRQ
Message-ID: <20191008102524.GB21036@x1.vandijck-laurijssen.be>
X-ASG-Orig-Subj: Re: [PATCH v2] can: c_can: c_can_poll(): only read status register
 after status IRQ
Mail-Followup-To: Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-can@vger.kernel.org,
        Joe Burmeister <joe.burmeister@devtank.co.uk>,
        Wolfgang Grandegger <wg@grandegger.com>
References: <20191008095707.23902-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191008095707.23902-1-mkl@pengutronix.de>
User-Agent: Mutt/1.5.22 (2013-10-16)
X-Barracuda-Connect: 77.109.105.74.adsl.dyn.edpnet.net[77.109.105.74]
X-Barracuda-Start-Time: 1570530326
X-Barracuda-URL: https://212.71.1.220:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 911
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: SPAM GLOBAL 1.0000 1.0000 4.3429
X-Barracuda-Spam-Score: 4.34
X-Barracuda-Spam-Status: No, SCORE=4.34 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.77213
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On di, 08 okt 2019 11:57:07 +0200, Marc Kleine-Budde wrote:
> From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
> 
> When the status register is read without status IRQ pending, it may get
> into a state that it goes into busoff state without having its irq
> activated, so the driver wil never know.
> 
> Thanks to Wolfgang and Joe for bringing up the first idea.
> 
> Signed-off-by: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
> Cc: Wolfgang Grandegger <wg@grandegger.com>
> Cc: Joe Burmeister <joe.burmeister@devtank.co.uk>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
> Hello,
> 
> as mentioned in another mail, I'll take this patch for the can branch to
> fix this problem before switching to rx-offload.

I understand. It's cleaner.
I didn't do so as 90% of this patch will dissappear when we merge the 2
halves together and migrate to rx-offload.

Kurt
