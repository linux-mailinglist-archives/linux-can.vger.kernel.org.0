Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 254C0549BBE
	for <lists+linux-can@lfdr.de>; Mon, 13 Jun 2022 20:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243936AbiFMSjF (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 13 Jun 2022 14:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344678AbiFMSik (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 13 Jun 2022 14:38:40 -0400
Received: from mail.enpas.org (zhong.enpas.org [IPv6:2a03:4000:2:537::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F08C837BFA
        for <linux-can@vger.kernel.org>; Mon, 13 Jun 2022 08:36:47 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        by mail.enpas.org (Postfix) with ESMTPSA id 316EA100029;
        Mon, 13 Jun 2022 15:36:46 +0000 (UTC)
Date:   Mon, 13 Jun 2022 17:36:43 +0200
From:   Max Staudt <max@enpas.org>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org
Subject: Re: [PATCH] can: netlink: allow configuring of fixed data bit rates
 without need for do_set_data_bittiming callback
Message-ID: <20220613173643.0092dcc0.max@enpas.org>
In-Reply-To: <20220613143633.4151884-1-mkl@pengutronix.de>
References: <20220613143633.4151884-1-mkl@pengutronix.de>
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

I've never used this feature, but I guess it looks good, thanks!

Acked-by: Max Staudt <max@enpas.org>
