Return-Path: <linux-can+bounces-5305-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E77FC2A6C5
	for <lists+linux-can@lfdr.de>; Mon, 03 Nov 2025 08:55:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3656C3AF987
	for <lists+linux-can@lfdr.de>; Mon,  3 Nov 2025 07:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF5CE2C08D9;
	Mon,  3 Nov 2025 07:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="rO9IiVFx"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A8923EA82
	for <linux-can@vger.kernel.org>; Mon,  3 Nov 2025 07:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762156338; cv=none; b=BCP0sRCcRVqM/zH6jc6N/qT75PoTfxgFzb6PlxcrCaYWid9HaF8su+3RiL1Cync5CSLYAQLALyzkGntbhe7gjp9Wfou06aF0uh1tfIussy1mPOXCtulcon3ONDRL0dSvHRXUNDIt12evlvN1n56e70zDQTg4HydrCTiD1MPQ3Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762156338; c=relaxed/simple;
	bh=xPw/EkaLjlYdn9ZRdoZnxkDOXDBERxtHMo4O7WD9kas=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X6PdvWivr3+u8h/s7nVWHgxfAkY7bg3ZHQ8KZzcCbdon3rGkDo/TS6PYmY/fPF9huDC4rSMYH5ii58mNdkyBIMcHK89+HssnUApbSuhTwaPKIlKx4a71X/Uz8jVREasWztmmCmkxn6cwVHzcu/3l4G3SLsZMNLenibQF2aWR+Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=rO9IiVFx; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-7866dcf50b1so7874287b3.3
        for <linux-can@vger.kernel.org>; Sun, 02 Nov 2025 23:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1762156336; x=1762761136; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PTPGXxwQZWvCNLJWtuoJDZzQORR3WU9efpFiIKez7WU=;
        b=rO9IiVFxmaSjqsEn2pFNiGITE1/Zj5oaL/wZ2GWhQ2DTHLaM+MmUHcGKUgwZy3XY7S
         jObW1RWJXBw9DbkIw9aGsGWs7G8iUkQ+6APstUadYfmfV8duAuykBpZBgIuc3fz+oic4
         t6cSa9II69jiAsnBCQeHJOk3J5+vuOsFC+DqM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762156336; x=1762761136;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PTPGXxwQZWvCNLJWtuoJDZzQORR3WU9efpFiIKez7WU=;
        b=sdyVwhbXKOVSnKlQ2TsAXRCG/7NAwRkiKoq287eZF0piwTZc6fw4Xqi2KvhMAVRxsd
         XBdygW4u84ZYjeorqQ9URF9GRmDucvgIlpQidihcnyEvuIvY4TJgB2BvaRutRn7M5B5m
         JKyJzSKD5ocD9CyLfsckjq0XtNY9xiekQYfUIfEba8n8jv5axxIiaXvqBC2lCHF3mYkN
         gykg4cIjiz4EvDWvsq294l+yMjt90HJvWB8s5KlDQ2Qm8cnXH0AeYBWt8btn+SZdo34c
         iFC8sVmYmnNstjcQoo5r6rB28IvrAktCqd6eyLkmgfjGQMWBLlDd9wSNKJR/SxLLXHt6
         LHKA==
X-Forwarded-Encrypted: i=1; AJvYcCU60it9hxJN65cM8vmRNBp0MBfto+uyqsBPrUaT0Mhih03LBVGt2ZUUj4YJLajToqQ3xv8mZYvDB4s=@vger.kernel.org
X-Gm-Message-State: AOJu0YycOhLt6wLsLHiQDICgCjdmVLpalQV4uvwZPz7D7kk4agNXmr6f
	Q3rDjWXmx0c8zPdRz4c7TNvYjXzoDI5Na1XpwlqoBSzenZDFRQYpYImmn9AlH6FDeBdR2IvuTmy
	STCq9lsJD1Q7w6uuycFF8WGQUq66eWYlSWc3S1yr+Fg==
X-Gm-Gg: ASbGncsixh6hGM1ceLitqHrDl8hWS2SJmgyo8lkWYU8PRJ4nUvOgETkcbDpihRBjdYf
	bIf/TrtP4bvkFZh38atRfQ+BAbr8I2sAtgS5C75Mw/U1Wz3qbe01QanLdsn0c8Wfw1uP71Bhx/x
	aQFEolN9byRq+zY/6newWwED9XofQsHwNxK3ijKisMBa9bSlDkHbjmKyfs0z1oi0504NjoQLHIG
	M+QbTwtBlzDN8CuN2yViSEoMsf0/JzW7pBIP9CmHWh9KRJbmzgobnN+cS02FYYc1s7G4w==
X-Google-Smtp-Source: AGHT+IGAfPzDZnSjcBo5Myj2OK8PIIoNEoQ7eah85P2JO/xYi8s9Xp3EhC8UeEUW1VJ503f9rhh6wA8w2vjiPiymoIo=
X-Received: by 2002:a05:690c:6009:b0:783:7143:d825 with SMTP id
 00721157ae682-78648435e5amr116889117b3.25.1762156335783; Sun, 02 Nov 2025
 23:52:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251103074009.4708-1-chuguangqing@inspur.com>
In-Reply-To: <20251103074009.4708-1-chuguangqing@inspur.com>
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Date: Mon, 3 Nov 2025 08:52:05 +0100
X-Gm-Features: AWmQ_bkybyhH8oApHqkt8s9JknLUAj7abzsc0GKdxF_HV51l07GhZgwMyQ-_55Y
Message-ID: <CABGWkvr0qA+xCLgfU37agbSS7O78u-GGpLjakcWjozR4QWYv=Q@mail.gmail.com>
Subject: Re: [PATCH] can: bxcan: Fix a typo error for assign
To: Chu Guangqing <chuguangqing@inspur.com>
Cc: mkl@pengutronix.de, mailhol@kernel.org, linux-can@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 3, 2025 at 8:42=E2=80=AFAM Chu Guangqing <chuguangqing@inspur.c=
om> wrote:
>
> Fix the spelling error of "assign".
>
> Signed-off-by: Chu Guangqing <chuguangqing@inspur.com>
> ---
>  drivers/net/can/bxcan.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/can/bxcan.c b/drivers/net/can/bxcan.c
> index 0b579e7bb3b6..baf494d20bef 100644
> --- a/drivers/net/can/bxcan.c
> +++ b/drivers/net/can/bxcan.c
> @@ -227,7 +227,7 @@ static void bxcan_enable_filters(struct bxcan_priv *p=
riv, enum bxcan_cfg cfg)
>          * mask mode with 32 bits width.
>          */
>
> -       /* Enter filter initialization mode and assing filters to CAN
> +       /* Enter filter initialization mode and assign filters to CAN
>          * controllers.
>          */
>         regmap_update_bits(priv->gcan, BXCAN_FMR_REG,
> --
> 2.43.7
>

Reviewed-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
--=20

Dario Binacchi

Senior Embedded Linux Developer

dario.binacchi@amarulasolutions.com

__________________________________


Amarula Solutions SRL

Via Le Canevare 30, 31100 Treviso, Veneto, IT

T. +39 042 243 5310
info@amarulasolutions.com

www.amarulasolutions.com

