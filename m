Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D088A1FCDFC
	for <lists+linux-can@lfdr.de>; Wed, 17 Jun 2020 15:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbgFQNAF (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 17 Jun 2020 09:00:05 -0400
Received: from relay-b02.edpnet.be ([212.71.1.222]:39338 "EHLO
        relay-b02.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbgFQNAF (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 17 Jun 2020 09:00:05 -0400
X-ASG-Debug-ID: 1592398801-0a7b8d5f4215395f0001-ZXuqFv
Received: from zotac.vandijck-laurijssen.be ([213.219.130.186]) by relay-b02.edpnet.be with ESMTP id yR4r9O8euayP1CG2; Wed, 17 Jun 2020 15:00:01 +0200 (CEST)
X-Barracuda-Envelope-From: dev.kurt@vandijck-laurijssen.be
X-Barracuda-Effective-Source-IP: UNKNOWN[213.219.130.186]
X-Barracuda-Apparent-Source-IP: 213.219.130.186
Received: from x1.vandijck-laurijssen.be (x1.vandijck-laurijssen.be [IPv6:fd01::1a1d:eaff:fe02:d339])
        by zotac.vandijck-laurijssen.be (Postfix) with ESMTPSA id 962B8F5F37D;
        Wed, 17 Jun 2020 14:59:54 +0200 (CEST)
Date:   Wed, 17 Jun 2020 14:59:49 +0200
From:   Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
To:     Arnej Duranovic <arnejduranovic@pm.me>
Cc:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: Re: J1939: /proc/net/can interface
Message-ID: <20200617125949.GA12583@x1.vandijck-laurijssen.be>
X-ASG-Orig-Subj: Re: J1939: /proc/net/can interface
Mail-Followup-To: Arnej Duranovic <arnejduranovic@pm.me>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
References: <4SjA_8nFwOgutMJ5YoVaQPwX-zU-3shqgm7lsWxNWIQas0hIsCMdujJJbEJXOdxFjnDlDTqaDs4yiOXhAgZUYDUKIHXKcwtih3aa1fL8LV4=@pm.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4SjA_8nFwOgutMJ5YoVaQPwX-zU-3shqgm7lsWxNWIQas0hIsCMdujJJbEJXOdxFjnDlDTqaDs4yiOXhAgZUYDUKIHXKcwtih3aa1fL8LV4=@pm.me>
User-Agent: Mutt/1.5.22 (2013-10-16)
X-Barracuda-Connect: UNKNOWN[213.219.130.186]
X-Barracuda-Start-Time: 1592398801
X-Barracuda-URL: https://212.71.1.222:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 1322
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.5135 1.0000 0.7500
X-Barracuda-Spam-Score: 0.75
X-Barracuda-Spam-Status: No, SCORE=0.75 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.82614
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello,


On di, 16 jun 2020 18:40:49 +0000, Arnej Duranovic wrote:
> Hello all,
> 
> Earlier versions of J1939 contained the following:
> 
> + 6. /proc/net/can-j1939 Interface.
> + --------------------------------
> +
> +   Files giving you a view on the in-kernel operation of J1939 are located at:
> +   /proc/net/j1939.
> +
> + 6.1 /proc/net/can-j1939/ecu
> +
> +   This file gives an overview of the known ECU's to the kernel.
> +   - iface : network interface they operate on.
> +   - SA : current address.
> +   - name : 64bit NAME
> +   - flags : 'L' = local, 'R' = remote
> 
> I am interested in what happened to this feature since I do not see it in the latest implementation or in the documentation?

The feature got removed, as (almost) all of the /proc interface
for making mainline integration easier.
The idea was to restore the required interfaces when necessary.

> 
> I am interested in retrieving "known ECU's to the kernel" in the latest implementation. What is recommended?

I understand your question. The simple answer right now is: there isn't.

we could debate about this being necessary in /proc,
or rather in debugfs,
since this knowledge should not be used in real applications?
Am I right that your intended use is debugging related?

Kind regards,
Kurt
