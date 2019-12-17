Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08AF1122C16
	for <lists+linux-can@lfdr.de>; Tue, 17 Dec 2019 13:43:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbfLQMnc (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 17 Dec 2019 07:43:32 -0500
Received: from relay-b02.edpnet.be ([212.71.1.222]:55940 "EHLO
        relay-b02.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727519AbfLQMnb (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 17 Dec 2019 07:43:31 -0500
X-ASG-Debug-ID: 1576586609-0a7b8d6cdf4df630001-ZXuqFv
Received: from zotac.vandijck-laurijssen.be (77.109.77.154.static.edpnet.net [77.109.77.154]) by relay-b02.edpnet.be with ESMTP id HkbZItp2HjXrYUVI; Tue, 17 Dec 2019 13:43:29 +0100 (CET)
X-Barracuda-Envelope-From: dev.kurt@vandijck-laurijssen.be
X-Barracuda-Effective-Source-IP: 77.109.77.154.static.edpnet.net[77.109.77.154]
X-Barracuda-Apparent-Source-IP: 77.109.77.154
Received: from x1.vandijck-laurijssen.be (74.250-240-81.adsl-static.isp.belgacom.be [81.240.250.74])
        by zotac.vandijck-laurijssen.be (Postfix) with ESMTPSA id CF93BBCD9FA;
        Tue, 17 Dec 2019 13:43:28 +0100 (CET)
Date:   Tue, 17 Dec 2019 13:43:27 +0100
From:   Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org,
        Andrejs Cainikovs <Andrejs.Cainikovs@netmodule.com>
Subject: Re: [PATCH 09/10] can: c_can: support 64 message objects for D_CAN
Message-ID: <20191217124327.GD22847@x1.vandijck-laurijssen.be>
X-ASG-Orig-Subj: Re: [PATCH 09/10] can: c_can: support 64 message objects for D_CAN
Mail-Followup-To: Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-can@vger.kernel.org,
        Andrejs Cainikovs <Andrejs.Cainikovs@netmodule.com>
References: <1576584994-15873-1-git-send-email-dev.kurt@vandijck-laurijssen.be>
 <1576584994-15873-10-git-send-email-dev.kurt@vandijck-laurijssen.be>
 <c98f81fb-9e4f-d489-5d33-cd2f13292aa4@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c98f81fb-9e4f-d489-5d33-cd2f13292aa4@pengutronix.de>
User-Agent: Mutt/1.5.22 (2013-10-16)
X-Barracuda-Connect: 77.109.77.154.static.edpnet.net[77.109.77.154]
X-Barracuda-Start-Time: 1576586609
X-Barracuda-URL: https://212.71.1.222:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 1179
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.5944 1.0000 0.7500
X-Barracuda-Spam-Score: 1.75
X-Barracuda-Spam-Status: No, SCORE=1.75 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=BSF_SC2_SA016_OB
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.78715
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
        1.00 BSF_SC2_SA016_OB       Custom Rule SA016_OB
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On di, 17 dec 2019 13:22:06 +0100, Marc Kleine-Budde wrote:
> On 12/17/19 1:16 PM, Kurt Van Dijck wrote:
> > From: Andrejs Cainikovs <Andrejs.Cainikovs@netmodule.com>
> > 
> > D_CAN supports up to 128 message objects, comparing to 32 on C_CAN.
> > However, some CPUs with D_CAN controller have their own limits:
> > TI AM335x Sitara CPU, for example, supports max of 64 message objects.
> > 
> > This patch extends max D_CAN message objects up to 64.
> > 
> > Signed-off-by: Andrejs Cainikovs <andrejs.cainikovs@netmodule.com>
> > Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> > Signed-off-by: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
> 
> NACK.
> 
> Do not make this a Kconfig option. Decide based on the compatible how
> many mailboxes to use.

OK.
At time of testing, I'd liked the option.
At this point, I follow your suggestion.
> 
> Marc
> 
> -- 
> Pengutronix e.K.                 | Marc Kleine-Budde           |
> Embedded Linux                   | https://www.pengutronix.de  |
> Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
> Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |
> 



