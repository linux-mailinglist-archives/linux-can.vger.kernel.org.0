Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F10DF122B59
	for <lists+linux-can@lfdr.de>; Tue, 17 Dec 2019 13:22:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbfLQMWG (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 17 Dec 2019 07:22:06 -0500
Received: from relay-b01.edpnet.be ([212.71.1.221]:37378 "EHLO
        relay-b01.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726747AbfLQMWF (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 17 Dec 2019 07:22:05 -0500
X-ASG-Debug-ID: 1576585323-0a7ff5137b1cdc830001-ZXuqFv
Received: from zotac.vandijck-laurijssen.be (77.109.77.154.adsl.dyn.edpnet.net [77.109.77.154]) by relay-b01.edpnet.be with ESMTP id vFG6rNrSE0Zqdwn8 for <linux-can@vger.kernel.org>; Tue, 17 Dec 2019 13:22:03 +0100 (CET)
X-Barracuda-Envelope-From: dev.kurt@vandijck-laurijssen.be
X-Barracuda-Effective-Source-IP: 77.109.77.154.adsl.dyn.edpnet.net[77.109.77.154]
X-Barracuda-Apparent-Source-IP: 77.109.77.154
Received: from x1.vandijck-laurijssen.be (74.250-240-81.adsl-static.isp.belgacom.be [81.240.250.74])
        by zotac.vandijck-laurijssen.be (Postfix) with ESMTPSA id 39741BCD957
        for <linux-can@vger.kernel.org>; Tue, 17 Dec 2019 13:22:03 +0100 (CET)
Date:   Tue, 17 Dec 2019 13:22:01 +0100
From:   Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
To:     linux-can@vger.kernel.org
Subject: Re: [RFC] c_can: improve latency and avoid packet loss
Message-ID: <20191217122201.GC22847@x1.vandijck-laurijssen.be>
X-ASG-Orig-Subj: Re: [RFC] c_can: improve latency and avoid packet loss
Mail-Followup-To: linux-can@vger.kernel.org
References: <1576584994-15873-1-git-send-email-dev.kurt@vandijck-laurijssen.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1576584994-15873-1-git-send-email-dev.kurt@vandijck-laurijssen.be>
User-Agent: Mutt/1.5.22 (2013-10-16)
X-Barracuda-Connect: 77.109.77.154.adsl.dyn.edpnet.net[77.109.77.154]
X-Barracuda-Start-Time: 1576585323
X-Barracuda-URL: https://212.71.1.221:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 1027
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: SPAM GLOBAL 0.9999 1.0000 4.3421
X-Barracuda-Spam-Score: 5.34
X-Barracuda-Spam-Status: No, SCORE=5.34 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=BSF_SC2_SA016_OB
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.78715
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
        1.00 BSF_SC2_SA016_OB       Custom Rule SA016_OB
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Marc,

for your convenience,
I pushed this to git@github.com:kurt-vd/linux.git c_can-next

Kurt

On di, 17 dec 2019 13:16:24 +0100, Kurt Van Dijck wrote:
> Date:   Tue, 17 Dec 2019 13:16:24 +0100
> From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
> To: linux-can@vger.kernel.org
> Subject: [RFC] c_can: improve latency and avoid packet loss
> X-Mailer: git-send-email 1.8.5.rc3
> 
> This series is my attempt to make avoid packet loss on a D_CAN chip.
> 
> It consists of adding a manual mode to rx-offload, with a temporary queue
> for use during ISR.
> The c_can ISR is re-organized to use rx-offload in manual mode.
> 
> This reduced the packet loss on our product _almost_ completely.
> 
> Finally, I added the commits in can-next/c_can-more-objects.
> 
> I observed no more packet loss since (monitoring for +/- 6 weeks).
> Our product runs a v4.9 kernel, on which I tuned the code.
> This series is a forward-ported version of it, on top of can-next.
> 
> Kind regards,
> Kurt
> 
> 
