Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73477122C1C
	for <lists+linux-can@lfdr.de>; Tue, 17 Dec 2019 13:45:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbfLQMpp (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 17 Dec 2019 07:45:45 -0500
Received: from relay-b01.edpnet.be ([212.71.1.221]:47378 "EHLO
        relay-b01.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727519AbfLQMpp (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 17 Dec 2019 07:45:45 -0500
X-ASG-Debug-ID: 1576586742-0a7ff5137e1ce0be0001-ZXuqFv
Received: from zotac.vandijck-laurijssen.be (77.109.77.154.static.edpnet.net [77.109.77.154]) by relay-b01.edpnet.be with ESMTP id 7C6MoY71PscLNG2N; Tue, 17 Dec 2019 13:45:42 +0100 (CET)
X-Barracuda-Envelope-From: dev.kurt@vandijck-laurijssen.be
X-Barracuda-Effective-Source-IP: 77.109.77.154.static.edpnet.net[77.109.77.154]
X-Barracuda-Apparent-Source-IP: 77.109.77.154
Received: from x1.vandijck-laurijssen.be (74.250-240-81.adsl-static.isp.belgacom.be [81.240.250.74])
        by zotac.vandijck-laurijssen.be (Postfix) with ESMTPSA id 4E605BCDA08;
        Tue, 17 Dec 2019 13:45:42 +0100 (CET)
Date:   Tue, 17 Dec 2019 13:45:40 +0100
From:   Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org
Subject: Re: [RFC] c_can: improve latency and avoid packet loss
Message-ID: <20191217124540.GE22847@x1.vandijck-laurijssen.be>
X-ASG-Orig-Subj: Re: [RFC] c_can: improve latency and avoid packet loss
Mail-Followup-To: Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-can@vger.kernel.org
References: <1576584994-15873-1-git-send-email-dev.kurt@vandijck-laurijssen.be>
 <c0272077-c3c1-f106-ef51-fee546368ba6@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c0272077-c3c1-f106-ef51-fee546368ba6@pengutronix.de>
User-Agent: Mutt/1.5.22 (2013-10-16)
X-Barracuda-Connect: 77.109.77.154.static.edpnet.net[77.109.77.154]
X-Barracuda-Start-Time: 1576586742
X-Barracuda-URL: https://212.71.1.221:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 1300
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.7484 1.0000 1.7593
X-Barracuda-Spam-Score: 2.76
X-Barracuda-Spam-Status: No, SCORE=2.76 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=BSF_SC2_SA016_OB
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.78716
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
        1.00 BSF_SC2_SA016_OB       Custom Rule SA016_OB
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On di, 17 dec 2019 13:26:19 +0100, Marc Kleine-Budde wrote:
> On 12/17/19 1:16 PM, Kurt Van Dijck wrote:
> > This series is my attempt to make avoid packet loss on a D_CAN chip.
> > 
> > It consists of adding a manual mode to rx-offload, with a temporary queue
> > for use during ISR.
> > The c_can ISR is re-organized to use rx-offload in manual mode.
> > 
> > This reduced the packet loss on our product _almost_ completely.
> > 
> > Finally, I added the commits in can-next/c_can-more-objects.
> 
> Nice. However I don't like the Kconfig options, make it dependent on the
> DT compatible. See the individual mails.
> 
> > I observed no more packet loss since (monitoring for +/- 6 weeks).
> > Our product runs a v4.9 kernel, on which I tuned the code.
> > This series is a forward-ported version of it, on top of can-next.
> 
> How many RX/TX mailboxes are you using?

48rx, 16tx. But I could reduce to 8tx or even 4tx too without har
without harm, as you suggested.

> 
> Marc
> 
> -- 
> Pengutronix e.K.                 | Marc Kleine-Budde           |
> Embedded Linux                   | https://www.pengutronix.de  |
> Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
> Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |
> 



