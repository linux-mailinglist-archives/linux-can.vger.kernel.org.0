Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F743B76EE
	for <lists+linux-can@lfdr.de>; Thu, 19 Sep 2019 12:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388998AbfISKBG (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 19 Sep 2019 06:01:06 -0400
Received: from relay-b03.edpnet.be ([212.71.1.220]:33661 "EHLO
        relay-b03.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388966AbfISKBG (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 19 Sep 2019 06:01:06 -0400
X-ASG-Debug-ID: 1568887263-0a88186e223c0a630001-ZXuqFv
Received: from zotac.vandijck-laurijssen.be (77.109.114.181.adsl.dyn.edpnet.net [77.109.114.181]) by relay-b03.edpnet.be with ESMTP id Kj58al7xcqG0QBp9 for <linux-can@vger.kernel.org>; Thu, 19 Sep 2019 12:01:03 +0200 (CEST)
X-Barracuda-Envelope-From: dev.kurt@vandijck-laurijssen.be
X-Barracuda-Effective-Source-IP: 77.109.114.181.adsl.dyn.edpnet.net[77.109.114.181]
X-Barracuda-Apparent-Source-IP: 77.109.114.181
Received: from x1.vandijck-laurijssen.be (74.250-240-81.adsl-static.isp.belgacom.be [81.240.250.74])
        by zotac.vandijck-laurijssen.be (Postfix) with ESMTPSA id B551D9DD625
        for <linux-can@vger.kernel.org>; Thu, 19 Sep 2019 12:01:03 +0200 (CEST)
Date:   Thu, 19 Sep 2019 12:01:02 +0200
From:   Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
To:     linux-can@vger.kernel.org
Subject: Question on priorities with CAN
Message-ID: <20190919100102.GD1446@x1.vandijck-laurijssen.be>
X-ASG-Orig-Subj: Question on priorities with CAN
Mail-Followup-To: linux-can@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.5.22 (2013-10-16)
X-Barracuda-Connect: 77.109.114.181.adsl.dyn.edpnet.net[77.109.114.181]
X-Barracuda-Start-Time: 1568887263
X-Barracuda-URL: https://212.71.1.220:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 424
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.6003 1.0000 0.7515
X-Barracuda-Spam-Score: 0.75
X-Barracuda-Spam-Status: No, SCORE=0.75 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.76589
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hey,

I work on a beaglebone-like board using the AM335x can chip, with an RT
kernel.

The can irq task is by default rt prio 50.
I have a process running on rt prio 10 using CAN_RAW socket.

I see that softirqd runs on regular timeslicing.
Do CAN frames need to pass through the softirqd in order to arrive
on my process?
I would need to elevate the softirqd's rt prio also in that case?

Kind regards,
Kurt
