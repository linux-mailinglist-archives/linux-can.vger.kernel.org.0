Return-Path: <linux-can+bounces-2674-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B2F8A18E12
	for <lists+linux-can@lfdr.de>; Wed, 22 Jan 2025 10:06:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 400B47A1B94
	for <lists+linux-can@lfdr.de>; Wed, 22 Jan 2025 09:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED5221F543D;
	Wed, 22 Jan 2025 09:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WelW4kHB"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408591C3C05
	for <linux-can@vger.kernel.org>; Wed, 22 Jan 2025 09:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737536758; cv=none; b=YCxu2S3XGVpFwq6WqRtELhn6aKhYwsXXMttMefALlUxf713eaWGse7hOowIOsLjnEi5dDWZOgeIq1R2ozzjlE0aDZJGqm0zgRKOKyNDAVHt6zIDpbv5CZhyQ2XoA/VqnLtRmYG8NcJ+XkSFg1m1uoMxYXLkufkjIU8bBYeUhp6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737536758; c=relaxed/simple;
	bh=vscg+fCWgn1XzfDcoGIsDN2CaUpEAjzVK0SJjA3DkQg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pAsqRUpkWIFWyFUw//hbcfJ90F8M1vuccPZMiYLSI+G3NJHwlyGobCfmGNMeHXfy3EGnmA1aO/sRVCg5mRU2QazQt6oofYw3YGJZCPDB069fMW6+7CLat5XGxbUDXT++2SsJqhE9H7butrvnUxJuNecTOLFH6vWADzlbbMWxmTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WelW4kHB; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ab39f84cbf1so842280866b.3
        for <linux-can@vger.kernel.org>; Wed, 22 Jan 2025 01:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737536755; x=1738141555; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vscg+fCWgn1XzfDcoGIsDN2CaUpEAjzVK0SJjA3DkQg=;
        b=WelW4kHB9LZUXJfCvArFp+AE9Rt7XvOaxTZKUS5yiBEm20xRB9hWE2KdZE8bAfXXh9
         uBIvg7hGHYSYpskN2T0cFiSaNNWmcXztm9COtc8KYKfvPLg1ek2PF1OtEFDlUcQdRnCK
         M5piZ5kDyKABrXK+LaOQol9+lZUeUZdkxeAzL4Uik4N0fHiaeVw7s3Yi5uBDa5MuLZG+
         Oi1OtJ4JBhVTJ9vuS7D0B4Jw9/UHhEfQNKRPodfEGyL79e9og5JHlzl1kLft+vlQXdrY
         4t5+hFCsDX5+y3bdcUHIeKwwLgwQpaYhQHqjV9242h1efP9YNG2r0IEg/YzXwLPAgoIX
         bTCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737536755; x=1738141555;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vscg+fCWgn1XzfDcoGIsDN2CaUpEAjzVK0SJjA3DkQg=;
        b=H+/brH4K044ee5nxnaga0hJsp03T8LQ8TJXj9uwgeFYe04n07iznC9eh/3d61REEUD
         l6Vvn5cXdLvBQowDH/cAeVtgvjvoBeaE6RvEC47vtY/ZlvKTQ9oS/ezprNWE3BT8uzx7
         G8f1mtFq4j7eiZJmKTSLlHJB5zP/+/S5YW/GnlDX9VbZGXF6Yrng70wv8dT+vB7pdZny
         zhKqAu1tb9DxEAReYVPXkipAgAzy55SobvMSJ3tTErcSO7WyjSVsYV4vUZ8kxuD7fv6+
         8kTyEN4ucWX0SBvhyth4U6NqHKCPBF1nxnKPUgUFo+DiR6gLerNYW5fnZM3Xir+IzbR5
         oMAw==
X-Gm-Message-State: AOJu0YzdTFltSAhOwQDyymm5N9sBb9WwbSYlHy2urSCJ3QEU+jjVQgpW
	10BYgxgyA8n8NVhjKOIXEkZAQJrS2LwUQKklJvohZRjT90xnXSAu1QLxNWlB3uAH9UzZqFl5JzS
	Ix3hXYwOq3uAEOBsSF109IvmzD8s=
X-Gm-Gg: ASbGncsFus5SfXsgza+OuuCcVkddtdklXSGtiE1g1QhM44ExoiETPbYznlaExnAB0Rv
	lsJvKBzouW9OiOUixpHuaOe7drUBzc+sTNiHWtvFlURtjetEt8Wc=
X-Google-Smtp-Source: AGHT+IFR/YoyFdEpHyiIFRAoIotnu51WrVChclRa7GtKbBFrCWpd1WyZtcvbedZuFPVdd4j27Xc/6hqUT/Ss/qXKowg=
X-Received: by 2002:a17:907:3f95:b0:aab:7467:3f6a with SMTP id
 a640c23a62f3a-ab38b159929mr1803406366b.21.1737536754968; Wed, 22 Jan 2025
 01:05:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250120133827.668977-1-henrik@brixandersen.dk>
In-Reply-To: <20250120133827.668977-1-henrik@brixandersen.dk>
From: Vincent Mailhol <vincent.mailhol@gmail.com>
Date: Wed, 22 Jan 2025 18:05:43 +0900
X-Gm-Features: AbW1kvY4CHnWt0CrHQxv5VX6FSse3tSC-mHcRbOyRkKlM6nxJAZ53AJuYt7EjrI
Message-ID: <CAMZ6RqKCoYu67KBu6iZZ0oVm1TxEJN706XwdNTMhUED5bNrVmw@mail.gmail.com>
Subject: Re: [PATCH] can: gs_usb: add VID/PID for the CANnectivity firmware
To: Henrik Brix Andersen <henrik@brixandersen.dk>
Cc: linux-can@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon. 20 Jan 2025 at 22:39, Henrik Brix Andersen
<henrik@brixandersen.dk> wrote:
> Add USB VID/PID for the CANnectivity USB to CAN adapter firmware.
>
> Signed-off-by: Henrik Brix Andersen <henrik@brixandersen.dk>

Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

