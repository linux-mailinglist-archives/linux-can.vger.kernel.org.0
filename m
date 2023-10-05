Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9BF07BA728
	for <lists+linux-can@lfdr.de>; Thu,  5 Oct 2023 18:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbjJEQza (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 5 Oct 2023 12:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232933AbjJEQyX (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 5 Oct 2023 12:54:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1048C35A7;
        Thu,  5 Oct 2023 09:44:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65F46C433C8;
        Thu,  5 Oct 2023 16:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696524262;
        bh=mK/SNXCOe8N+XAarC6tZtnfOgjStW1fvXDMBaMxfJQw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZRHuwt1WdMrORRlFmhmDt9j/0/po7jJOFwurVcNILq3hUsOLteIjKuR2a9nw4usuT
         qD8H4/cUTBU1arQNV1qp6FXe1wHkZQ1+NPfCmLT+s3OlQBJoTa4WTVRBNkf8vesknV
         2WZtCCkaG3o6+f8hWEzgnurvUK+XN9WQgiiJCq6QMj3iraTR/AWEbrYjklsk8u/PU0
         B+WZ56dolOKWlFOpDBH9VQZPqWcClCJOHvsjxOD1k+UKwzKbJ6eOrBp1gKWuWVXejk
         rIfZtUzv6j7qn8sxctnHkpnsOyjX0MxAIOrnsnwvKu3LZGgsW5hsKz1U3nudoXllRu
         0QvoHmm43+7AQ==
Date:   Thu, 5 Oct 2023 09:44:21 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     netdev@vger.kernel.org, davem@davemloft.net,
        linux-can@vger.kernel.org, kernel@pengutronix.de,
        Sili Luo <rootlab@huawei.com>, stable@vger.kernel.org
Subject: Re: [PATCH net 1/7] can: j1939: Fix UAF in j1939_sk_match_filter
 during setsockopt(SO_J1939_FILTER)
Message-ID: <20231005094421.09a6a58f@kernel.org>
In-Reply-To: <20231005094639.387019-2-mkl@pengutronix.de>
References: <20231005094639.387019-1-mkl@pengutronix.de>
        <20231005094639.387019-2-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Thu,  5 Oct 2023 11:46:33 +0200 Marc Kleine-Budde wrote:
> Lock jsk->sk to prevent UAF when setsockopt(..., SO_J1939_FILTER, ...)
> modifies jsk->filters while receiving packets.

Doesn't it potentially introduce sleep in atomic?

j1939_sk_recv_match()
  spin_lock_bh(&priv->j1939_socks_lock);
  j1939_sk_recv_match_one()
    j1939_sk_match_filter()
      lock_sock()
        sleep
