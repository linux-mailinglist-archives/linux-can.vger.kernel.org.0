Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4E5C9FC7E
	for <lists+linux-can@lfdr.de>; Wed, 28 Aug 2019 10:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbfH1IAi convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-can@lfdr.de>); Wed, 28 Aug 2019 04:00:38 -0400
Received: from relay-b01.edpnet.be ([212.71.1.221]:58247 "EHLO
        relay-b01.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726378AbfH1IAi (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 28 Aug 2019 04:00:38 -0400
X-Greylist: delayed 1100 seconds by postgrey-1.27 at vger.kernel.org; Wed, 28 Aug 2019 04:00:37 EDT
X-ASG-Debug-ID: 1566978135-0a7ff535a32eddb10001-ZXuqFv
Received: from zotac.vandijck-laurijssen.be (77.109.114.181.adsl.dyn.edpnet.net [77.109.114.181]) by relay-b01.edpnet.be with ESMTP id iAI9zC41HvKJtVLl; Wed, 28 Aug 2019 09:42:15 +0200 (CEST)
X-Barracuda-Envelope-From: dev.kurt@vandijck-laurijssen.be
X-Barracuda-Effective-Source-IP: 77.109.114.181.adsl.dyn.edpnet.net[77.109.114.181]
X-Barracuda-Apparent-Source-IP: 77.109.114.181
Received: from [10.115.52.56] (unknown [185.194.187.16])
        by zotac.vandijck-laurijssen.be (Postfix) with ESMTPSA id DE808988025;
        Wed, 28 Aug 2019 09:42:14 +0200 (CEST)
Date:   Wed, 28 Aug 2019 09:42:11 +0200
User-Agent: K-9 Mail for Android
In-Reply-To: <0c9554e4-55cc-3c51-68f6-3575e4d857b1@pengutronix.de>
References: <20190828065226.23604-1-mkl@pengutronix.de> <20190828065226.23604-19-mkl@pengutronix.de> <0c9554e4-55cc-3c51-68f6-3575e4d857b1@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH 18/21] can: introduce REQUIRED_SIZE macro
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        "linux-can @ vger . kernel . org" <linux-can@vger.kernel.org>
X-ASG-Orig-Subj: Re: [PATCH 18/21] can: introduce REQUIRED_SIZE macro
CC:     kernel@pengutronix.de, Oleksij Rempel <o.rempel@pengutronix.de>
From:   Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Message-ID: <BC2B9C1E-FC4B-4B3F-B70A-6A57E0817C79@vandijck-laurijssen.be>
X-Barracuda-Connect: 77.109.114.181.adsl.dyn.edpnet.net[77.109.114.181]
X-Barracuda-Start-Time: 1566978135
X-Barracuda-URL: https://212.71.1.221:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 784
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.7795 1.0000 2.0322
X-Barracuda-Spam-Score: 2.03
X-Barracuda-Spam-Status: No, SCORE=2.03 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.75809
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Yes, you can.
It's equally mee, but the eia.be address is obsolete

On 28 August 2019 08:56:48 GMT+02:00, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>On 8/28/19 8:52 AM, Marc Kleine-Budde wrote:
>> From: Kurt Van Dijck <kurt.van.dijck@eia.be>
>> 
>> The size of this structure will be increased with J1939 support.
>> To stay binary compatible, the REQUIRED_SIZE macro is introduced
>> for existing CAN protocols.
>> 
>> Signed-off-by: Kurt Van Dijck <kurt.van.dijck@eia.be>
>> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
>> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
>
>Kurt, can I change your S-o-b to "Kurt Van Dijck
><dev.kurt@vandijck-laurijssen.be>"?
>
>For this and the following patch.
>
>Marc

Sent from a small mobile device
