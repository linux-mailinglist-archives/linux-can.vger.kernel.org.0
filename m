Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC26347CC5
	for <lists+linux-can@lfdr.de>; Wed, 24 Mar 2021 16:37:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236653AbhCXPgy (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 24 Mar 2021 11:36:54 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:46304 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236648AbhCXPge (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 24 Mar 2021 11:36:34 -0400
X-Greylist: delayed 333 seconds by postgrey-1.27 at vger.kernel.org; Wed, 24 Mar 2021 11:36:34 EDT
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 25930608F44C
        for <linux-can@vger.kernel.org>; Wed, 24 Mar 2021 16:30:59 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 6rUQrndYfzQs for <linux-can@vger.kernel.org>;
        Wed, 24 Mar 2021 16:30:58 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id CB2CB608F448
        for <linux-can@vger.kernel.org>; Wed, 24 Mar 2021 16:30:58 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id EOf86SEyXZur for <linux-can@vger.kernel.org>;
        Wed, 24 Mar 2021 16:30:58 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id AC7CB606BA27
        for <linux-can@vger.kernel.org>; Wed, 24 Mar 2021 16:30:58 +0100 (CET)
Date:   Wed, 24 Mar 2021 16:30:58 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     linux-can@vger.kernel.org
Message-ID: <1883346738.111675.1616599858539.JavaMail.zimbra@nod.at>
Subject: Breaking UAPI change?
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF78 (Linux)/8.8.12_GA_3809)
Thread-Index: i95Ht5GBF8pTCLR2V25CkB/f5VLg4A==
Thread-Topic: Breaking UAPI change?
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi!

commit f5223e9eee65 ("can: extend sockaddr_can to include j1939 members") increased the size of 
struct sockaddr_can.
This is a problem for applications which use recvfrom() with addrlen being sizeof(struct sockaddr_can)
or sizeof(struct sockaddr).
If such an application was built before the change it will no longer function correctly on newer kernels.
In fact I ran into such a scenario and found the said commit later that day.

Is this a known issue?
Or is this allowed and application must not use sizeof(struct sockaddr_can) as addrlen?
If so, what is the proposed way to avoid future breakage?

Thanks,
//richard
