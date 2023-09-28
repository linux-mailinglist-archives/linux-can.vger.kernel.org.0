Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DBBF7B1C98
	for <lists+linux-can@lfdr.de>; Thu, 28 Sep 2023 14:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232576AbjI1Mgd (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 28 Sep 2023 08:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232514AbjI1MgZ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 28 Sep 2023 08:36:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 751E2139
        for <linux-can@vger.kernel.org>; Thu, 28 Sep 2023 05:36:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D90D4C433C8;
        Thu, 28 Sep 2023 12:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695904584;
        bh=IFrcf1HPc0zyK3iLaNG9gOuBji+30hPiT2IlRSdShVg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SmmsEIeoEjtbXkbPElRqp9gu3YYdGTtyOl6LSOrsqPNKvrJFBRvd4hunEGDSG6ofF
         ovLsJsACNdNoUM4hd6kEo9as/IwAqEZguEWwjdD6NwPRcTMTh+p6xqSvR4RIvgJgu+
         YmjfMwTxsHXWApRPheJwSj8gVnxWb1CeGP6xT59uHhTjqji5ALA12XRlmJ+pBNfi5g
         oOPIT6PW5FOMaMZhmhxwhMNd4QU9BAyiKGefbOXgW/CyHLHiQFByktsIztcvENhPAK
         mwBfGB3UiLqiOg4YWK0090U7eqQduQWo92OJ/J82nX/Ki0ClHfZvG3bsLx2pzrH2Jq
         dPtXVfiCHHfBA==
Date:   Thu, 28 Sep 2023 14:35:56 +0200
From:   Simon Horman <horms@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
        linux-can@vger.kernel.org,
        =?utf-8?B?SsOpcsOpbWll?= Dautheribes 
        <jeremie.dautheribes@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        sylvain.girard@se.com, pascal.eberhard@se.com
Subject: Re: [PATCH net-next] can: sja1000: Fix comment
Message-ID: <20230928123556.GH24230@kernel.org>
References: <20230922155130.592187-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230922155130.592187-1-miquel.raynal@bootlin.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Fri, Sep 22, 2023 at 05:51:30PM +0200, Miquel Raynal wrote:
> There is likely a copy-paste error here, as the exact same comment
> appears below in this function, one time calling set_reset_mode(), the
> other set_normal_mode().
> 
> Fixes: 429da1cc841b ("can: Driver for the SJA1000 CAN controller")

I'm not sure this warrants a fixes tag, which implies backporting,
but in any case the tag is correct.

> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

The above comment notwithstanding, this seems correct to me.

Reviewed-by: Simon Horman <horms@kernel.org>
