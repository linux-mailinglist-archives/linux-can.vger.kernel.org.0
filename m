Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 089B5C2708
	for <lists+linux-can@lfdr.de>; Mon, 30 Sep 2019 22:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729775AbfI3UpI (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 30 Sep 2019 16:45:08 -0400
Received: from relay-b03.edpnet.be ([212.71.1.220]:50512 "EHLO
        relay-b03.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729245AbfI3UpH (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 30 Sep 2019 16:45:07 -0400
X-ASG-Debug-ID: 1569871849-0a88186e23435ee80001-ZXuqFv
Received: from zotac.vandijck-laurijssen.be (77.109.119.18.adsl.dyn.edpnet.net [77.109.119.18]) by relay-b03.edpnet.be with ESMTP id 5ffpBD3ApRW7Obwy for <linux-can@vger.kernel.org>; Mon, 30 Sep 2019 21:30:49 +0200 (CEST)
X-Barracuda-Envelope-From: dev.kurt@vandijck-laurijssen.be
X-Barracuda-Effective-Source-IP: 77.109.119.18.adsl.dyn.edpnet.net[77.109.119.18]
X-Barracuda-Apparent-Source-IP: 77.109.119.18
Received: from x1.vandijck-laurijssen.be (x1.vandijck-laurijssen.be [192.168.0.36])
        by zotac.vandijck-laurijssen.be (Postfix) with ESMTPSA id BA0CDA1A583;
        Mon, 30 Sep 2019 21:30:48 +0200 (CEST)
From:   Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
To:     linux-can@vger.kernel.org
Cc:     dev.kurt@vandijck-laurijssen.be
Subject: [RFC] c_can improvements
Date:   Mon, 30 Sep 2019 21:30:40 +0200
X-ASG-Orig-Subj: [RFC] c_can improvements
Message-Id: <1569871843-28655-1-git-send-email-dev.kurt@vandijck-laurijssen.be>
X-Mailer: git-send-email 1.8.5.rc3
X-Barracuda-Connect: 77.109.119.18.adsl.dyn.edpnet.net[77.109.119.18]
X-Barracuda-Start-Time: 1569871849
X-Barracuda-URL: https://212.71.1.220:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 650
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.7639 1.0000 1.8932
X-Barracuda-Spam-Score: 1.89
X-Barracuda-Spam-Status: No, SCORE=1.89 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.76973
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

Kind regards,
Kurt

