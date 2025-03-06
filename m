Return-Path: <linux-can+bounces-2985-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B026A5437C
	for <lists+linux-can@lfdr.de>; Thu,  6 Mar 2025 08:16:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E3227A8F72
	for <lists+linux-can@lfdr.de>; Thu,  6 Mar 2025 07:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A3101DC9AC;
	Thu,  6 Mar 2025 07:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="f3SzWnFk"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (out-13.smtpout.orange.fr [193.252.22.13])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB901A2846;
	Thu,  6 Mar 2025 07:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741245324; cv=none; b=BCaJctFB2EAbxMuvAIgkZn6MIYdF/k4+vXGTJeqj2fq7lrFBRQWluM+nZUuxGc78oAMavOd7IW7zXbflHgbSrzQKcTEoPgMVnzn6c7lE2jcSB/gOlrJ5oE0+IHtNiXhR5hXn30SxZ7ghVl6U8fHGlp2v45+hPQo7hHk47uMHJsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741245324; c=relaxed/simple;
	bh=7IUWR6VRphGA3aYG0HEflrporgT5Cn484F0bHIkP0Cw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tJAxhwddHDMWpBb9xwy2io8XL9IQpbVO4/YQrCePOf4vO/m3yLiAE91Q7eprLZrBflgiAdynjPOg0Jc3DaEvZ5voByRYaHSki2I3+Swg/CtQe3MViHFvWUpI4w/kHfXe255FKiWhCZXrINa/7nWKfyiL0V8pMm/6CtjmGTw8f7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=f3SzWnFk; arc=none smtp.client-ip=193.252.22.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from mail-ej1-f51.google.com ([209.85.218.51])
	by smtp.orange.fr with ESMTPSA
	id q5RrtKn7dP9tpq5RutIUq9; Thu, 06 Mar 2025 08:15:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1741245318;
	bh=7IUWR6VRphGA3aYG0HEflrporgT5Cn484F0bHIkP0Cw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To;
	b=f3SzWnFkBHBNsSUVUak8ipH/vV54a6yvsobqC5kUVQU2mhMQIunOM255/nxBlDg4w
	 vs/unQ9pk2y3gOQPhayvwDcvuMN8y/h1DksXa2YbthX9888tAt9Neoo/Zw+zq5TfRR
	 dwGCrPb0bCDryWRzUl+j/JsGmTuRV3eCXeEUcKMB6k0HAYgSOvPaU4bj0f7wgiT3cs
	 xcMjxkM/RSAUuRbRv3PDUr+FSELcC2HGzaO4L2jDThQOXqaBWOr9HYVcOBds1ddWVi
	 +TVeJWKf7MrXCYqkq+NEjN3rQ/PgORB7IfACrAdmEAvFJYr5M75xCvsDkM7pBFeleW
	 1vxiBQWo8ByiA==
X-ME-Helo: mail-ej1-f51.google.com
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Thu, 06 Mar 2025 08:15:18 +0100
X-ME-IP: 209.85.218.51
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-abbd96bef64so50861966b.3;
        Wed, 05 Mar 2025 23:15:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWvzNzgCAiB1S0NF6L+9Qxv3fyJ+hima0iU7P1TJIX5emM2yxN9lftEGltpfpv2Olq+J3jzoSkvnps=@vger.kernel.org, AJvYcCX4YBdfh7Vxtqaov6/FTEGSuh5tFCPvEIKeHXzHsazqwmvY3KC75FJi/wnAr/8pxByluzyscGFE/ynsoSAB@vger.kernel.org
X-Gm-Message-State: AOJu0YzU9afT5VDLXYlOhkrbDXvXF/BSXVIcOb/WRTN87231z/dq4e5W
	hrpBF+7lt9XYVFJjQ5BX8deGQ81wJACrXds0L6zaWdr/19gQnLEcExDMQAeWakXVG6gSGcUT6kt
	F151pUcVu9NJ120uP70Adi8mKj1Q=
X-Google-Smtp-Source: AGHT+IH8hhh6oAYyC6uPKA9rsfgpkWm6NvzIO7DuDV3vZ2zHoYRgLCoR764aoz0s0rZpSzABXV4x3MLsFt2ljnQKjUc=
X-Received: by 2002:a17:907:c302:b0:abe:c894:5986 with SMTP id
 a640c23a62f3a-ac20dae1ff1mr707065166b.39.1741245315138; Wed, 05 Mar 2025
 23:15:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250306065921.2329517-1-haibo.chen@nxp.com>
In-Reply-To: <20250306065921.2329517-1-haibo.chen@nxp.com>
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Date: Thu, 6 Mar 2025 16:15:03 +0900
X-Gmail-Original-Message-ID: <CAMZ6Rq+XNSCKLucZkiMReh+8M4Enh2s0ugHzdkJeGT1=d+GkLw@mail.gmail.com>
X-Gm-Features: AQ5f1JpY8DmpHY3mF04-zFYQMw4LTMTeBGxWIrKJrVySNOR79ap0KMlA_eWB2ik
Message-ID: <CAMZ6Rq+XNSCKLucZkiMReh+8M4Enh2s0ugHzdkJeGT1=d+GkLw@mail.gmail.com>
Subject: Re: [PATCH 1/2] can: flexcan: only set CAN_STATE_ERROR_ACTIVE when
 resume has no issue
To: haibo.chen@nxp.com
Cc: mkl@pengutronix.de, ciprianmarian.costea@oss.nxp.com, han.xu@nxp.com, 
	u.kleine-koenig@baylibre.com, linux-can@vger.kernel.org, 
	linux-kernel@vger.kernel.org, imx@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Thu. 6 Mar 2025 at 15:58, <haibo.chen@nxp.com> wrote:
> From: Haibo Chen <haibo.chen@nxp.com>
>
> Only set CAN state to CAN_STATE_ERROR_ACTIVE when resume process has
> no issue, otherwise keep in CAN_STATE_SLEEPING as suspend did.
>
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>

Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

