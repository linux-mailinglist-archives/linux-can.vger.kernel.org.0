Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 819F6DA6B0
	for <lists+linux-can@lfdr.de>; Thu, 17 Oct 2019 09:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438551AbfJQHsf (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 17 Oct 2019 03:48:35 -0400
Received: from relay-b02.edpnet.be ([212.71.1.222]:44555 "EHLO
        relay-b02.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387930AbfJQHsf (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 17 Oct 2019 03:48:35 -0400
X-ASG-Debug-ID: 1571298513-0a7b8d13c0883e90001-ZXuqFv
Received: from zotac.vandijck-laurijssen.be (77.109.116.161.adsl.dyn.edpnet.net [77.109.116.161]) by relay-b02.edpnet.be with ESMTP id tfc7NIEBsUVyj8yv for <linux-can@vger.kernel.org>; Thu, 17 Oct 2019 09:48:33 +0200 (CEST)
X-Barracuda-Envelope-From: dev.kurt@vandijck-laurijssen.be
X-Barracuda-Effective-Source-IP: 77.109.116.161.adsl.dyn.edpnet.net[77.109.116.161]
X-Barracuda-Apparent-Source-IP: 77.109.116.161
Received: from x1.vandijck-laurijssen.be (74.250-240-81.adsl-static.isp.belgacom.be [81.240.250.74])
        by zotac.vandijck-laurijssen.be (Postfix) with ESMTPSA id DAE14A7C595
        for <linux-can@vger.kernel.org>; Thu, 17 Oct 2019 09:48:32 +0200 (CEST)
Date:   Thu, 17 Oct 2019 09:48:27 +0200
From:   Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
To:     linux-can@vger.kernel.org
Subject: Re: [PATCH] c_can using rx-offload
Message-ID: <20191017074827.GB700@x1.vandijck-laurijssen.be>
X-ASG-Orig-Subj: Re: [PATCH] c_can using rx-offload
Mail-Followup-To: linux-can@vger.kernel.org
References: <20191009074338.GA23530@x1.vandijck-laurijssen.be>
 <1570614515-14765-1-git-send-email-dev.kurt@vandijck-laurijssen.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1570614515-14765-1-git-send-email-dev.kurt@vandijck-laurijssen.be>
User-Agent: Mutt/1.5.22 (2013-10-16)
X-Barracuda-Connect: 77.109.116.161.adsl.dyn.edpnet.net[77.109.116.161]
X-Barracuda-Start-Time: 1571298513
X-Barracuda-URL: https://212.71.1.222:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 465
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.5056 1.0000 0.7500
X-Barracuda-Spam-Score: 0.75
X-Barracuda-Spam-Status: No, SCORE=0.75 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.77389
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Ping? I forgot to tag this one a v4 probably
On wo, 09 okt 2019 11:48:32 +0200, Kurt Van Dijck wrote:
> This patch series reduces the number of locks on the rx-offload skb_queue,
> by using a secondary irq_skb_queue, which is appended all-at-once
> at the end.
> A seconds improvement for c_can is that the tx echo uses the same
> path to enter the system.
> 
> It's under test now, I hope this removes all CAN hw overflow problems
> that I observed.
> 
