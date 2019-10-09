Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE70D1240
	for <lists+linux-can@lfdr.de>; Wed,  9 Oct 2019 17:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729644AbfJIPQx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-can@lfdr.de>); Wed, 9 Oct 2019 11:16:53 -0400
Received: from relay-b03.edpnet.be ([212.71.1.220]:44622 "EHLO
        relay-b03.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727920AbfJIPQx (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 9 Oct 2019 11:16:53 -0400
X-ASG-Debug-ID: 1570634210-0a88186e2249a0600001-ZXuqFv
Received: from zotac.vandijck-laurijssen.be (77.109.105.74.adsl.dyn.edpnet.net [77.109.105.74]) by relay-b03.edpnet.be with ESMTP id 95RiMtxobQqWBXxO; Wed, 09 Oct 2019 17:16:50 +0200 (CEST)
X-Barracuda-Envelope-From: dev.kurt@vandijck-laurijssen.be
X-Barracuda-Effective-Source-IP: 77.109.105.74.adsl.dyn.edpnet.net[77.109.105.74]
X-Barracuda-Apparent-Source-IP: 77.109.105.74
Received: from moto5gs.vandijck-laurijssen.be (moto5gs.vandijck-laurijssen.be [192.168.0.35])
        by zotac.vandijck-laurijssen.be (Postfix) with ESMTPSA id 297B3A4D34B;
        Wed,  9 Oct 2019 17:16:50 +0200 (CEST)
Date:   Wed, 09 Oct 2019 17:16:49 +0200
User-Agent: K-9 Mail for Android
In-Reply-To: <135b3582-d7c2-a4a1-9956-1560e3c928db@pengutronix.de>
References: <1570001287-32420-1-git-send-email-dev.kurt@vandijck-laurijssen.be> <bbf6fa6e-665c-2bb5-4d73-c5734ed78e27@pengutronix.de> <135b3582-d7c2-a4a1-9956-1560e3c928db@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH] can-rx-offload: free echo_skb when not queued
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org,
        Jeroen Hofstee <jhofstee@victronenergy.com>
X-ASG-Orig-Subj: Re: [PATCH] can-rx-offload: free echo_skb when not queued
From:   Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Message-ID: <69625A73-F9FC-4E78-B1FA-5DEB629D6C70@vandijck-laurijssen.be>
X-Barracuda-Connect: 77.109.105.74.adsl.dyn.edpnet.net[77.109.105.74]
X-Barracuda-Start-Time: 1570634210
X-Barracuda-URL: https://212.71.1.220:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 532
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.6277 1.0000 0.8893
X-Barracuda-Spam-Score: 1.49
X-Barracuda-Spam-Status: No, SCORE=1.49 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=MARKETING_SUBJECT
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.77251
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
        0.60 MARKETING_SUBJECT      Subject contains popular marketing words
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 9 October 2019 15:47:51 GMT+02:00, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>On 10/9/19 3:20 PM, Marc Kleine-Budde wrote:
>> On 10/2/19 9:28 AM, Kurt Van Dijck wrote:
>>> Signed-off-by: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
>> 
>> Applied to linux-can.
>
>I think I'll move the kfree() to can_rx_offload_queue_sorted().
>
>There are several places already and the risk it too high, that it's
>forgotten.
What about the unsorted variant?
>
>Opinions?
>
>Marc

Sent from a small mobile device
