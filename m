Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3861DC2E4B
	for <lists+linux-can@lfdr.de>; Tue,  1 Oct 2019 09:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732905AbfJAHkt (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 1 Oct 2019 03:40:49 -0400
Received: from relay-b02.edpnet.be ([212.71.1.222]:59952 "EHLO
        relay-b02.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731358AbfJAHks (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 1 Oct 2019 03:40:48 -0400
X-ASG-Debug-ID: 1569915646-0a7b8d53c1e3e250001-ZXuqFv
Received: from zotac.vandijck-laurijssen.be (77.109.119.18.adsl.dyn.edpnet.net [77.109.119.18]) by relay-b02.edpnet.be with ESMTP id JX7H8wduf2yJSWNe; Tue, 01 Oct 2019 09:40:46 +0200 (CEST)
X-Barracuda-Envelope-From: dev.kurt@vandijck-laurijssen.be
X-Barracuda-Effective-Source-IP: 77.109.119.18.adsl.dyn.edpnet.net[77.109.119.18]
X-Barracuda-Apparent-Source-IP: 77.109.119.18
Received: from x1.vandijck-laurijssen.be (74.250-240-81.adsl-static.isp.belgacom.be [81.240.250.74])
        by zotac.vandijck-laurijssen.be (Postfix) with ESMTPSA id B41A1A1D9C9;
        Tue,  1 Oct 2019 09:40:45 +0200 (CEST)
From:   Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
To:     linux-can@vger.kernel.org
Cc:     dev.kurt@vandijck-laurijssen.be, jhofstee@victronenergy.com
Subject: [RFC v2] c_can improvements
Date:   Tue,  1 Oct 2019 09:40:35 +0200
X-ASG-Orig-Subj: [RFC v2] c_can improvements
Message-Id: <1569915638-4605-1-git-send-email-dev.kurt@vandijck-laurijssen.be>
X-Mailer: git-send-email 1.8.5.rc3
X-Barracuda-Connect: 77.109.119.18.adsl.dyn.edpnet.net[77.109.119.18]
X-Barracuda-Start-Time: 1569915646
X-Barracuda-URL: https://212.71.1.222:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 751
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.6486 1.0000 1.0125
X-Barracuda-Spam-Score: 1.01
X-Barracuda-Spam-Status: No, SCORE=1.01 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.76991
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

First patch will (try to) remove lost busoff conditions by not reading
the status register wihtout pending status interrupt.
This has ran for several weeks, and not produced any lost busoff (I'm
not sure it would have issued a true positive in this time).
I run this on a beaglebone-alike board.

Next patch will tear c_can bottom halve isr out of napi so I can better control
it's RT priority without affecting other napi handlers in the same softirq.

Last patch will combine top and bottom halve isr in case of force irq threading
like on an RT kernel. Having the irq split across 2 threads does not seem wise.

Changes since v1:
I refactored the 1/3 to avoid a merge conflict with patches of Jeroen Hofstee.

Kind regards,
Kurt

