Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB4F354761A
	for <lists+linux-can@lfdr.de>; Sat, 11 Jun 2022 17:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238330AbiFKPYt (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 11 Jun 2022 11:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237799AbiFKPYs (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 11 Jun 2022 11:24:48 -0400
Received: from mail.enpas.org (zhong.enpas.org [46.38.239.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A33DB25E99
        for <linux-can@vger.kernel.org>; Sat, 11 Jun 2022 08:24:47 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        by mail.enpas.org (Postfix) with ESMTPSA id 3B0AC100022;
        Sat, 11 Jun 2022 15:24:46 +0000 (UTC)
Date:   Sat, 11 Jun 2022 17:24:38 +0200
From:   Max Staudt <max@enpas.org>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org
Subject: Re: [PATCH] can: netlink: allow configuring of fixed bit rates
 without need for do_set_bittiming callback
Message-ID: <20220611172438.59ad6167.max@enpas.org>
In-Reply-To: <20220611144248.3924903-1-mkl@pengutronix.de>
References: <20220611144248.3924903-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Thank you!

As discussed, after 3 years of can327/elmcan with the dummy function, I
believe this to be thoroughly tested ;)

Tested-by: Max Staudt <max@enpas.org>
