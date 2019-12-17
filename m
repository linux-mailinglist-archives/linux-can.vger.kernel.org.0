Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95CFD122B19
	for <lists+linux-can@lfdr.de>; Tue, 17 Dec 2019 13:17:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727868AbfLQMRF (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 17 Dec 2019 07:17:05 -0500
Received: from relay-b01.edpnet.be ([212.71.1.221]:34932 "EHLO
        relay-b01.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727857AbfLQMRF (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 17 Dec 2019 07:17:05 -0500
X-ASG-Debug-ID: 1576585022-0a7ff5137d1cda580001-ZXuqFv
Received: from zotac.vandijck-laurijssen.be (77.109.77.154.static.edpnet.net [77.109.77.154]) by relay-b01.edpnet.be with ESMTP id DuxcrgXgRtCchFA5 for <linux-can@vger.kernel.org>; Tue, 17 Dec 2019 13:17:02 +0100 (CET)
X-Barracuda-Envelope-From: dev.kurt@vandijck-laurijssen.be
X-Barracuda-Effective-Source-IP: 77.109.77.154.static.edpnet.net[77.109.77.154]
X-Barracuda-Apparent-Source-IP: 77.109.77.154
Received: from x1.vandijck-laurijssen.be (74.250-240-81.adsl-static.isp.belgacom.be [81.240.250.74])
        by zotac.vandijck-laurijssen.be (Postfix) with ESMTPSA id 44AC5BCD8EE;
        Tue, 17 Dec 2019 13:17:02 +0100 (CET)
From:   Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
To:     linux-can@vger.kernel.org
Subject: [RFC] c_can: improve latency and avoid packet loss
Date:   Tue, 17 Dec 2019 13:16:24 +0100
X-ASG-Orig-Subj: [RFC] c_can: improve latency and avoid packet loss
Message-Id: <1576584994-15873-1-git-send-email-dev.kurt@vandijck-laurijssen.be>
X-Mailer: git-send-email 1.8.5.rc3
X-Barracuda-Connect: 77.109.77.154.static.edpnet.net[77.109.77.154]
X-Barracuda-Start-Time: 1576585022
X-Barracuda-URL: https://212.71.1.221:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 590
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: SPAM GLOBAL 0.9987 1.0000 4.3284
X-Barracuda-Spam-Score: 4.33
X-Barracuda-Spam-Status: No, SCORE=4.33 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.78715
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This series is my attempt to make avoid packet loss on a D_CAN chip.

It consists of adding a manual mode to rx-offload, with a temporary queue
for use during ISR.
The c_can ISR is re-organized to use rx-offload in manual mode.

This reduced the packet loss on our product _almost_ completely.

Finally, I added the commits in can-next/c_can-more-objects.

I observed no more packet loss since (monitoring for +/- 6 weeks).
Our product runs a v4.9 kernel, on which I tuned the code.
This series is a forward-ported version of it, on top of can-next.

Kind regards,
Kurt


