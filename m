Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 764C1701DB0
	for <lists+linux-can@lfdr.de>; Sun, 14 May 2023 16:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233488AbjENOAv (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 14 May 2023 10:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjENOAu (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 14 May 2023 10:00:50 -0400
X-Greylist: delayed 549 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 14 May 2023 07:00:48 PDT
Received: from mailgw.felk.cvut.cz (mailgw.felk.cvut.cz [147.32.82.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9F881FD3;
        Sun, 14 May 2023 07:00:48 -0700 (PDT)
Received: from mailgw.felk.cvut.cz (localhost.localdomain [127.0.0.1])
        by mailgw.felk.cvut.cz (Proxmox) with ESMTP id BE21B30AE008;
        Sun, 14 May 2023 15:51:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        cmp.felk.cvut.cz; h=cc:cc:content-transfer-encoding:content-type
        :content-type:date:from:from:in-reply-to:message-id:mime-version
        :references:reply-to:subject:subject:to:to; s=felkmail; bh=e2g3s
        W+NGB6tMVsRb8QdC7Dj6Z/tfRXnRbnnZAhkoDQ=; b=pSsjU26pZX0Ky7zPJLuap
        PykZ07U7aT864ej3y7a4rqQ3BS7bIb7M83lIHAuzn5fsDaCjChrhVLm8gpmf4mHS
        mw0ojBGlD7VHTTDc8yep7FriN628T1gierllbDl7QBhBLhekXy7pRY3XM/bP6Wph
        aVLL6CU2XnXYf1J0/8KfVED90DQewXLpeMfFTK+qXCf6dLbaq7mBkVZnUNE/Y2Ts
        8pEJs2werP3HehrP42GzukKypZiQ7r0beGUcS2kYQ3vFcFxFpcDrVg6D9dZ8uNue
        ef6G9ouGTZsBdNmf9bvfnMvwm3CcdsPECuOI3WUaSyMwnXDoHu3c2i7QYTCwG4zi
        Q==
Received: from cmp.felk.cvut.cz (haar.felk.cvut.cz [147.32.84.19])
        by mailgw.felk.cvut.cz (Proxmox) with ESMTPS id 3DE0030AD9FF;
        Sun, 14 May 2023 15:51:05 +0200 (CEST)
Received: from haar.felk.cvut.cz (localhost [127.0.0.1])
        by cmp.felk.cvut.cz (8.14.0/8.12.3/SuSE Linux 0.6) with ESMTP id 34EDp5j7022768;
        Sun, 14 May 2023 15:51:05 +0200
Received: (from pisa@localhost)
        by haar.felk.cvut.cz (8.14.0/8.13.7/Submit) id 34EDp4oj022766;
        Sun, 14 May 2023 15:51:04 +0200
X-Authentication-Warning: haar.felk.cvut.cz: pisa set sender to pisa@cmp.felk.cvut.cz using -f
From:   Pavel Pisa <pisa@cmp.felk.cvut.cz>
To:     "Uwe =?utf-8?q?Kleine-K=C3=B6nig?=" <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 06/19] can: ctucanfd: Convert to platform remove callback returning void
Date:   Sun, 14 May 2023 15:50:59 +0200
User-Agent: KMail/1.9.10
Cc:     Ondrej Ille <ondrej.ille@gmail.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        "Marc Kleine-Budde" <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, kernel@pengutronix.de
References: <20230512212725.143824-1-u.kleine-koenig@pengutronix.de> <20230512212725.143824-7-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20230512212725.143824-7-u.kleine-koenig@pengutronix.de>
X-KMail-QuotePrefix: > 
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <202305141550.59128.pisa@cmp.felk.cvut.cz>
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Friday 12 of May 2023 23:27:12 Uwe Kleine-K=C3=B6nig wrote:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is ignored (apart from
> emitting a warning) and this typically results in resource leaks. To
> improve here there is a quest to make the remove callback return void. In
> the first step of this quest all drivers are converted to .remove_new()
> which already returns void. Eventually after all drivers are converted,
> .remove_new() is renamed to .remove().
>
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Acked-by: Pavel Pisa <pisa@cmp.felk.cvut.cz>

Thanks for maintenace, Pavel.

