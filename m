Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8148F58340A
	for <lists+linux-can@lfdr.de>; Wed, 27 Jul 2022 22:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbiG0UYZ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 27 Jul 2022 16:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiG0UYY (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 27 Jul 2022 16:24:24 -0400
Received: from mail.enpas.org (zhong.enpas.org [IPv6:2a03:4000:2:537::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E488C5F997
        for <linux-can@vger.kernel.org>; Wed, 27 Jul 2022 13:24:23 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        by mail.enpas.org (Postfix) with ESMTPSA id 678E5FF897;
        Wed, 27 Jul 2022 20:24:22 +0000 (UTC)
Date:   Wed, 27 Jul 2022 22:24:20 +0200
From:   Max Staudt <max@enpas.org>
To:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        Stephane Grosjean <s.grosjean@peak-system.com>,
        Jimmy Assarsson <extja@kvaser.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>
Subject: Re: [PATCH v4 01/14] can: can327: add software tx timestamps
Message-ID: <20220727222420.6b626b29.max@enpas.org>
In-Reply-To: <20220727101641.198847-2-mailhol.vincent@wanadoo.fr>
References: <20220725133208.432176-1-mailhol.vincent@wanadoo.fr>
        <20220727101641.198847-1-mailhol.vincent@wanadoo.fr>
        <20220727101641.198847-2-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Wed, 27 Jul 2022 19:16:28 +0900
Vincent Mailhol <mailhol.vincent@wanadoo.fr> wrote:

> TX timestamps were added to the can_put_echo_skb() function of can_dev
> modules in [1]. However, can327 does not rely on that function and as
> such does not offer TX timestamping.
> 
> Add a call to skb_tx_timestamp() in the can327_netdev_start_xmit()
> function so that the module now supports TX software timestamps.
> 
> [1] commit 741b91f1b0ea ("can: dev: can_put_echo_skb(): add software
> tx timestamps")
> Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=741b91f1b0ea34f00f6a7d4539b767c409291fcf


Thanks!

Note to self: When I get around to do prober TX echo, I'll need to
remove this again...


Max
