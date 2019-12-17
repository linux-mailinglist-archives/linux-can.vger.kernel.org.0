Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1928012302D
	for <lists+linux-can@lfdr.de>; Tue, 17 Dec 2019 16:23:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728618AbfLQPXc (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 17 Dec 2019 10:23:32 -0500
Received: from relay-b03.edpnet.be ([212.71.1.220]:37245 "EHLO
        relay-b03.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728431AbfLQPXc (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 17 Dec 2019 10:23:32 -0500
X-ASG-Debug-ID: 1576596209-0a8818388316293a0001-ZXuqFv
Received: from zotac.vandijck-laurijssen.be (77.109.77.154.wls.msr91gen3.adsl.dyn.edpnet.net [77.109.77.154]) by relay-b03.edpnet.be with ESMTP id y4zSicGZywzHb2u6 for <linux-can@vger.kernel.org>; Tue, 17 Dec 2019 16:23:29 +0100 (CET)
X-Barracuda-Envelope-From: dev.kurt@vandijck-laurijssen.be
X-Barracuda-Effective-Source-IP: 77.109.77.154.wls.msr91gen3.adsl.dyn.edpnet.net[77.109.77.154]
X-Barracuda-Apparent-Source-IP: 77.109.77.154
Received: from x1.vandijck-laurijssen.be (74.250-240-81.adsl-static.isp.belgacom.be [81.240.250.74])
        by zotac.vandijck-laurijssen.be (Postfix) with ESMTPSA id D1C98BCDEB4;
        Tue, 17 Dec 2019 16:23:28 +0100 (CET)
From:   Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
To:     linux-can@vger.kernel.org
Subject: [RFC v3] c_can: improve latency and avoid packet loss
Date:   Tue, 17 Dec 2019 16:23:23 +0100
X-ASG-Orig-Subj: [RFC v3] c_can: improve latency and avoid packet loss
Message-Id: <1576596206-27260-1-git-send-email-dev.kurt@vandijck-laurijssen.be>
X-Mailer: git-send-email 1.8.5.rc3
In-Reply-To: <c0272077-c3c1-f106-ef51-fee546368ba6@pengutronix.de>
References: <c0272077-c3c1-f106-ef51-fee546368ba6@pengutronix.de>
X-Barracuda-Connect: 77.109.77.154.wls.msr91gen3.adsl.dyn.edpnet.net[77.109.77.154]
X-Barracuda-Start-Time: 1576596209
X-Barracuda-URL: https://212.71.1.220:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 220
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.5116 1.0000 0.7500
X-Barracuda-Spam-Score: 0.75
X-Barracuda-Spam-Status: No, SCORE=0.75 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.78718
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hey,

V3 is the 2nd attempt to omit KConfig values.
patches 1..8 are still identical.

I changed the order of 9,10,11 patches since V2
so that I never need any KConfig values.

Still open for remarks.

Kurt

