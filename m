Return-Path: <linux-can+bounces-2986-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6EDCA54377
	for <lists+linux-can@lfdr.de>; Thu,  6 Mar 2025 08:16:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFD5A3AFF05
	for <lists+linux-can@lfdr.de>; Thu,  6 Mar 2025 07:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D831CEAB2;
	Thu,  6 Mar 2025 07:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="dBGq7ER/"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (out-11.smtpout.orange.fr [193.252.22.11])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9D21624F2;
	Thu,  6 Mar 2025 07:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741245358; cv=none; b=CmhltI8mBO4GJaoQkHJBUiGHN92CXNbS/ImGpWesL8n0TN3Dgu62n9wmrTe68P26pcv8+mDa3zfZjjB2r2SwyyivBxIVRmhoXxO0yEPhyX+7zzlw8wiVrr126Jh/MAKxUCWrlBmJCSyzF+o8zmwefdAnvS/RBjNzGyv6M9eEWRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741245358; c=relaxed/simple;
	bh=0418C/W8KiV5zE5TlgyDvTR1gSi2KXM/MYdvecfDGyc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jU+NxziKVaMjIaXzYSMalYk4gxnPpIV3g3NJdnLDcidcVzDD6wKhiqFGfGZCh38VsxQMoh3jHYTP5LBtpx7V4bgkKpIZlEvYjvUUz4FT552BiEgsK6NT2HFfiU2zzEitmZh87zUgb5NVfeBGThJzkZs42nRTdKsa0arS/353wZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=dBGq7ER/; arc=none smtp.client-ip=193.252.22.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from mail-ej1-f48.google.com ([209.85.218.48])
	by smtp.orange.fr with ESMTPSA
	id q5SQtG4G098gkq5STtpo9o; Thu, 06 Mar 2025 08:15:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1741245353;
	bh=0418C/W8KiV5zE5TlgyDvTR1gSi2KXM/MYdvecfDGyc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To;
	b=dBGq7ER/ePc0sqDdiH8H4DqqlDl14Pu6GoMdV6pvOLRmh0HlopF+rEXMaayouqhv4
	 G9cosSX/eLUyVLDxrQQ/XIjT+wsmjr2papT0LVsgssPzMrBaObK0yfsEvjuIR4VayC
	 WA/bSW8Axldy8fkct2bHKreKeR6BYpSPpal160SFjvoBVMFupJU/owooK0V1vkJydF
	 an4skbMwF9hmruqciyuY7YgDPeQNUI6WNcqzpITdBPmvL1mS2+/x3tF26T9DGDVZNl
	 dtNMQkONH9mUNxG7oUz1YgkOLImPBuEG81AJ3pd+adg2gEEqNIQi1k3YF409bs0Jwa
	 79ib5s3sNARNQ==
X-ME-Helo: mail-ej1-f48.google.com
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Thu, 06 Mar 2025 08:15:53 +0100
X-ME-IP: 209.85.218.48
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aaedd529ba1so48140166b.1;
        Wed, 05 Mar 2025 23:15:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVe6T8nQS7BlVm4+tpqHYHr+sqV5m75w1DZ+hKOUl26svm2L69n+ZmwEfOtLEA8Kqv7q56sn0tSqus=@vger.kernel.org, AJvYcCWNAp9F8Pg/FTRTv+Ioq8oDi9UUeQvbI7Jnz3If1fdrwj18QpokiY0WK2qOgl6Mqwi72UVG2xX566tG9j9l@vger.kernel.org
X-Gm-Message-State: AOJu0YwwTH8m/aRyyizx8GGTdrn5En7xOCjTNzY6Gla2/Dm7V5NkiR4P
	96nZgWlMGwbXZHsm5fm1f7Hnkh974Mk7H6gIshrMf0yx73YRZIeVaVSYYr2dYTSkYeT7lW34BAw
	orvF594P2rUsFctuFIZfiy19sixE=
X-Google-Smtp-Source: AGHT+IFm3MQS5dgUYs1J7ifAfjVQ57iJeI+pjUmHRcmb45bQF4uoMwgIZEif/LCb+H/9N+qRcChkDTYQ1VADoEncMp4=
X-Received: by 2002:a05:6402:13cd:b0:5dc:74fd:abf1 with SMTP id
 4fb4d7f45d1cf-5e59f3ee29amr14210055a12.15.1741245347074; Wed, 05 Mar 2025
 23:15:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250306065921.2329517-1-haibo.chen@nxp.com> <20250306065921.2329517-2-haibo.chen@nxp.com>
In-Reply-To: <20250306065921.2329517-2-haibo.chen@nxp.com>
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Date: Thu, 6 Mar 2025 16:15:35 +0900
X-Gmail-Original-Message-ID: <CAMZ6RqLZNeTsmXkdxyUtiu016xuqbPeG1jyiE1WMPVNrhS=dAw@mail.gmail.com>
X-Gm-Features: AQ5f1JrdIDM0fL-S0vORrvulswXM_f2Ms6biMDjYK9kiDkIB2GoOPzf_rtumh5Y
Message-ID: <CAMZ6RqLZNeTsmXkdxyUtiu016xuqbPeG1jyiE1WMPVNrhS=dAw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] can: flexcan: disable transceiver during system PM
To: haibo.chen@nxp.com
Cc: mkl@pengutronix.de, ciprianmarian.costea@oss.nxp.com, han.xu@nxp.com, 
	u.kleine-koenig@baylibre.com, linux-can@vger.kernel.org, 
	linux-kernel@vger.kernel.org, imx@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Thu. 6 Mar 2025 at 15:58, <haibo.chen@nxp.com> wrote:
> From: Haibo Chen <haibo.chen@nxp.com>
>
> During system PM, if no wakeup requirement, disable transceiver to
> save power.
>
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>

Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

For this series, I guess you want to add stable@vger.kernel.org in CC.
Power saving seems worth a backport to me :)
Marc, maybe you can take care of this when applying?

Yours sincerely,
Vincent Mailhol

