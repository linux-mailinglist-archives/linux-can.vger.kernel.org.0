Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3260B122D79
	for <lists+linux-can@lfdr.de>; Tue, 17 Dec 2019 14:53:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728388AbfLQNxS (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 17 Dec 2019 08:53:18 -0500
Received: from relay-b02.edpnet.be ([212.71.1.222]:59165 "EHLO
        relay-b02.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728642AbfLQNxS (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 17 Dec 2019 08:53:18 -0500
X-ASG-Debug-ID: 1576590794-0a7b8d6cdf4ec410001-ZXuqFv
Received: from zotac.vandijck-laurijssen.be (77.109.77.154.static.edpnet.net [77.109.77.154]) by relay-b02.edpnet.be with ESMTP id Drfvqr4vGNRjir3A for <linux-can@vger.kernel.org>; Tue, 17 Dec 2019 14:53:14 +0100 (CET)
X-Barracuda-Envelope-From: dev.kurt@vandijck-laurijssen.be
X-Barracuda-Effective-Source-IP: 77.109.77.154.static.edpnet.net[77.109.77.154]
X-Barracuda-Apparent-Source-IP: 77.109.77.154
Received: from x1.vandijck-laurijssen.be (74.250-240-81.adsl-static.isp.belgacom.be [81.240.250.74])
        by zotac.vandijck-laurijssen.be (Postfix) with ESMTPSA id 654A2BCDC06;
        Tue, 17 Dec 2019 14:53:14 +0100 (CET)
From:   Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
To:     linux-can@vger.kernel.org
Subject: [RFC v2] c_can: improve latency and avoid packet loss
Date:   Tue, 17 Dec 2019 14:53:03 +0100
X-ASG-Orig-Subj: [RFC v2] c_can: improve latency and avoid packet loss
Message-Id: <1576590786-22075-1-git-send-email-dev.kurt@vandijck-laurijssen.be>
X-Mailer: git-send-email 1.8.5.rc3
In-Reply-To: <c0272077-c3c1-f106-ef51-fee546368ba6@pengutronix.de>
References: <c0272077-c3c1-f106-ef51-fee546368ba6@pengutronix.de>
X-Barracuda-Connect: 77.109.77.154.static.edpnet.net[77.109.77.154]
X-Barracuda-Start-Time: 1576590794
X-Barracuda-URL: https://212.71.1.222:443/cgi-mod/mark.cgi
X-Barracuda-BRTS-Status: 1
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 195
X-Barracuda-Bayes: INNOCENT GLOBAL 0.8134 1.0000 2.3488
X-Barracuda-Spam-Score: 2.35
X-Barracuda-Spam-Status: No, SCORE=2.35 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.78717
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

changes in v2:
64 msg objects is no longer configurable,
neither is the assymetric split of 8 tx/ N-8 rx objects.

Not tested yet, first see if it's right to do so.

Kind regards,
Kurt

