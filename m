Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4FC09A3B6
	for <lists+linux-can@lfdr.de>; Fri, 23 Aug 2019 01:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394369AbfHVXXM (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 22 Aug 2019 19:23:12 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:50512 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394362AbfHVXXM (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 22 Aug 2019 19:23:12 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id E1BAF1539D836;
        Thu, 22 Aug 2019 16:23:10 -0700 (PDT)
Date:   Thu, 22 Aug 2019 16:23:10 -0700 (PDT)
Message-Id: <20190822.162310.1544602687585865172.davem@davemloft.net>
To:     Markus.Elfring@web.de
Cc:     linux-can@vger.kernel.org, netdev@vger.kernel.org,
        allison@lohutok.net, lkml@metux.net, gregkh@linuxfoundation.org,
        gustavo@embeddedor.com, lukas@wunner.de, mkl@pengutronix.de,
        sean@geanix.com, tglx@linutronix.de, houweitaoo@gmail.com,
        wg@grandegger.com, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] can: Delete unnecessary checks before the macro call
 =?iso-2022-jp?B?GyRCIUgbKEJkZXZfa2ZyZWVfc2tiGyRCIUkbKEI=?=
From:   David Miller <davem@davemloft.net>
In-Reply-To: <27674907-fd2a-7f0c-84fd-d8b5124739a9@web.de>
References: <27674907-fd2a-7f0c-84fd-d8b5124739a9@web.de>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 22 Aug 2019 16:23:11 -0700 (PDT)
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Markus Elfring <Markus.Elfring@web.de>
Date: Wed, 21 Aug 2019 21:30:11 +0200

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Wed, 21 Aug 2019 21:16:15 +0200
> 
> The dev_kfree_skb() function performs also input parameter validation.
> Thus the test around the shown calls is not needed.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Applied.
