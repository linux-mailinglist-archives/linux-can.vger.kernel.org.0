Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3ADFCF7E5
	for <lists+linux-can@lfdr.de>; Tue,  8 Oct 2019 13:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730278AbfJHLNA (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 8 Oct 2019 07:13:00 -0400
Received: from relay-b03.edpnet.be ([212.71.1.220]:53236 "EHLO
        relay-b03.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729790AbfJHLNA (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 8 Oct 2019 07:13:00 -0400
X-ASG-Debug-ID: 1570533175-0a88186e2348bcef0001-ZXuqFv
Received: from zotac.vandijck-laurijssen.be (77.109.105.74.adsl.dyn.edpnet.net [77.109.105.74]) by relay-b03.edpnet.be with ESMTP id RaWa6pSa6QMp7om3; Tue, 08 Oct 2019 13:12:55 +0200 (CEST)
X-Barracuda-Envelope-From: dev.kurt@vandijck-laurijssen.be
X-Barracuda-Effective-Source-IP: 77.109.105.74.adsl.dyn.edpnet.net[77.109.105.74]
X-Barracuda-Apparent-Source-IP: 77.109.105.74
Received: from x1.vandijck-laurijssen.be (74.250-240-81.adsl-static.isp.belgacom.be [81.240.250.74])
        by zotac.vandijck-laurijssen.be (Postfix) with ESMTPSA id 23B07A47C48;
        Tue,  8 Oct 2019 13:12:55 +0200 (CEST)
Date:   Tue, 8 Oct 2019 13:12:53 +0200
From:   Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org,
        Joe Burmeister <joe.burmeister@devtank.co.uk>
Subject: Re: [PATCH v3 0/4] can: c_can/rx-offload
Message-ID: <20191008111253.GF21036@x1.vandijck-laurijssen.be>
X-ASG-Orig-Subj: Re: [PATCH v3 0/4] can: c_can/rx-offload
Mail-Followup-To: Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-can@vger.kernel.org,
        Joe Burmeister <joe.burmeister@devtank.co.uk>
References: <20191008075226.12544-1-mkl@pengutronix.de>
 <20191008080711.GA20524@x1.vandijck-laurijssen.be>
 <002eccee-3357-2ed8-5ba8-6f1a39b345bc@pengutronix.de>
 <20191008082404.GC20524@x1.vandijck-laurijssen.be>
 <a7579a05-53a6-00b8-e084-1025d5e9adbe@pengutronix.de>
 <20191008103247.GC21036@x1.vandijck-laurijssen.be>
 <558f7402-73cb-770a-7a24-5d417d5b2bb7@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <558f7402-73cb-770a-7a24-5d417d5b2bb7@pengutronix.de>
User-Agent: Mutt/1.5.22 (2013-10-16)
X-Barracuda-Connect: 77.109.105.74.adsl.dyn.edpnet.net[77.109.105.74]
X-Barracuda-Start-Time: 1570533175
X-Barracuda-URL: https://212.71.1.220:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 566
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: SPAM GLOBAL 0.9957 1.0000 4.2930
X-Barracuda-Spam-Score: 4.29
X-Barracuda-Spam-Status: No, SCORE=4.29 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.77214
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On di, 08 okt 2019 12:39:45 +0200, Marc Kleine-Budde wrote:
> On 10/8/19 12:32 PM, Kurt Van Dijck wrote:
> > On di, 08 okt 2019 10:32:18 +0200, Marc Kleine-Budde wrote:
> >> On 10/8/19 10:24 AM, Kurt Van Dijck wrote:
> 
> Tnx. Can you test the c_can branch from linux-can-next?

That's the hard part, I can not advance kernel version at this point.
So a long-term test is out of question at this point.

Funcionally, the rx-offload patch does the same as my inplace fifo patch
and that worked fine.

I'll see where I can get with a bench test.

Kurt
