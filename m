Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3EB3A9AEB
	for <lists+linux-can@lfdr.de>; Wed, 16 Jun 2021 14:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232664AbhFPMtR (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 16 Jun 2021 08:49:17 -0400
Received: from mail-lf1-f41.google.com ([209.85.167.41]:41710 "EHLO
        mail-lf1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233068AbhFPMtJ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 16 Jun 2021 08:49:09 -0400
Received: by mail-lf1-f41.google.com with SMTP id h4so4126087lfu.8
        for <linux-can@vger.kernel.org>; Wed, 16 Jun 2021 05:47:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hGSYVdIquGHqgBpM1YMOl2n5dkqXyFkeadbP+cHf4Cs=;
        b=t3fkAoMD7kBvgeS44R6AFgyiuZRhYEufVkqp9sBiHRPKUOzYiuUt3Sj2Heti47rqRr
         4CueAypQgmtHGX+L8+NOPB4zYYGjbsG8G/E2nrtMqjvOjnXTVhB4OyAhF9s5x2pdlCeI
         PUsZqZq2DDp8r7QpZnUjx1Ku3ljTho9SjltoNS9hFRe0UZVmn8O0sFIjNOtiHW/xa4MK
         ufjohzl5CQrAvp4vWFprBGQGNe7HDNXDrHoenxk9Kf7gvxkAoc3GbGDNHkqimLAjQZ4S
         1Xky6Pd4S/YxtylcIXDdAp3vhPRWjcEF0tSlQqQrYtWmFFJiCs8cF8sIwdKfCdAPJ/EY
         /upA==
X-Gm-Message-State: AOAM530gODTFC14hMuVpJWy7vJZp0RC83tq3B4ji3kCUOsypLCBhlU7R
        h+QthZfl8dAvedUyWaO1eN8gajoMYaP8zOBy/qw=
X-Google-Smtp-Source: ABdhPJxuzHPOt8Sepu1si7DmUx8eceRbdcuSCdX65gZ8G19Sf4z7mUJ58701aUQca2EYQ88vBYtATbm/tW0BbQ2eZHg=
X-Received: by 2002:ac2:53ad:: with SMTP id j13mr3797973lfh.594.1623847621219;
 Wed, 16 Jun 2021 05:47:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210616095922.2430415-1-mkl@pengutronix.de>
In-Reply-To: <20210616095922.2430415-1-mkl@pengutronix.de>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Wed, 16 Jun 2021 21:46:50 +0900
Message-ID: <CAMZ6RqKkjaN00UiN9BFD5FB_xra0tMtFKGU3QXzvLCeJuhYMUg@mail.gmail.com>
Subject: Re: [PATCH] can: bittiming: fix documentation for struct can_tdc::tdcv
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can <linux-can@vger.kernel.org>, kernel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Wed. 16 Jun 2021 at 18:59, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> This patch fixes a typo in the documentation for struct can_tdc::tdcv.
> The number "0" refers to automatic mode not the letter "O".
>
> Fixes: 289ea9e4ae59 ("can: add new CAN FD bittiming parameters: Transmitter Delay Compensation (TDC)")
> Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>  include/linux/can/bittiming.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

Thank you!
