Return-Path: <linux-can+bounces-5609-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F9FC7DC7F
	for <lists+linux-can@lfdr.de>; Sun, 23 Nov 2025 07:52:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DEF974E048D
	for <lists+linux-can@lfdr.de>; Sun, 23 Nov 2025 06:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B0DA1AAE17;
	Sun, 23 Nov 2025 06:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nptpr+jY"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65C21D555
	for <linux-can@vger.kernel.org>; Sun, 23 Nov 2025 06:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763880759; cv=none; b=iP9knP+js8muTjffpraIvhr3veeydh5DffwL5JnGAsPznSXNpMpxrBQtnmFA/TItIGfGCjewXhpFwk9P5pQH7ALp/RLIgDi1//Xa1LWCnP2HK48up8ssS00RJFp4em7ovNsn60NqmODYTWkKcgSjjBAIp81WZ6eCWPXEkxYzOcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763880759; c=relaxed/simple;
	bh=/5smio6fEPWQ0/kv6mvmWRYt8gJf8qf1v7F3Yum+/BQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iTVy/5raBDEgC7abYD7lg8zDEM61s9f0ywV2rtBL/IIhKkoqDm7lF2+oFsRXdiah3POh3hOgaFPy24U6Z8Ch8rqVzeBQ9wgi1vH/oZfXGwXDu1IhI2lbP9BugnrJW3CwxCK8zfEXjW72sltjamnur1p2jzdAp2HAuCaah5bg9hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nptpr+jY; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2984dfae043so29489905ad.0
        for <linux-can@vger.kernel.org>; Sat, 22 Nov 2025 22:52:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763880757; x=1764485557; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JQiIIdp7jTyKP7/P6x9gVFeSlDO/iD4H7+4qNKSakIE=;
        b=nptpr+jYDt4wP3aT1dxx7RfUuT8wzuPui3vrg1pC7l8t7EOKR+V7eEzT4zgIMtSk6A
         Gy28/co3/iXcucamSuyXUhTRZur41z5Hem33YDzFBLF+f2/CZ/yLspfqumSuKCmXh9ws
         0oWhPGzgcuh3wqZXGbr4oZegJZm3zVv0ybB4ukurdJyCtvQ945bmxgi04YmNCdDEvSOO
         v6JPhbrW926rkYA40UDNZ+WdEDxL/qjI1wxAiQxIn3NyHkcSfsIzlEqNGs0FRUyoCqLC
         nLzIMCA7u+vsjPXRv6vZuP6+KVtKrSgwKZ+v6UMNn4W0hmfOU4fcQXvjDUhPl2Bbzhqv
         qvcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763880757; x=1764485557;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JQiIIdp7jTyKP7/P6x9gVFeSlDO/iD4H7+4qNKSakIE=;
        b=quzM2zNmGIOvIpzFJPcZYIrr4fq1DTmra0oLTgh1nf/1dtdS2bMman/UAl+en+R6As
         SDuLmHa7jAu8b1s09STPYGcfbiVpYkjQaSHsrWhC5BCVdj0ZBZ0q2fvi+qnUyZWAfcj9
         eRZ8fW3sy6AE9DWvr/LzZEeZC9aSj8hVxcVAhXWKGTpd1qgM6CF1D1kFdNUep8zqDV1e
         vG6zspUyWq3ZOGYBE7IlCDtCgKHq7Z7NIi49vGmuUCj9wO8cunNtunIj5j4HGmja50Sl
         IFd1+/osA7UVyx/qK1eOGMEKuDR66qBfQr5365Sfq5YUD11aoCyPj3tmaSloMejVdwSl
         XV2w==
X-Gm-Message-State: AOJu0YxL9mxqKAc8lb0gYFzQL9g/UaSRBqxYFd5LMMkc9M8M+cIxer4C
	vMA7RqDk/N92AhLVkN24gDM53jySdjQmSdSRdKxa6h5pJPq5bNsb8d1i
X-Gm-Gg: ASbGncu/cdW38ualsd6xO3W/sFTmzZzOIwt0pVOdLVJk9xVOAt8FQKzbfSq4hLLfNbn
	IIzJcE69sVFsWLzKmZkWssqdfy3rGZ3nVudxqPY5aaoREC9DPGcH4MVWgyMxpM/R93kE6CKb6L2
	K0y1Xzlmr6xCk1fXqUw8o68VlpJ8pevJ6eOenZagXKhJ/rrak5V5rGh4nvT5cOQSKbcEYzVSf4e
	0XoMwDrTdz54bgMt5byG4swkGKilRAD/oxeM59U8+Cj4k12OQ7SF1VClQHm8az0X2ZcK2Dce2Ao
	8SDyI6znwW5xw+7W1A9cw/g0VQ7zn1zs+8orj3N8CS5KkFKhaYw5UEszGlXrTrwY0y9yIBtcr40
	0UU9l3r9G8V2HPKz3nYqzjuJbTc4IRmwx+jJL9MKGuHLpyx3YHJlYaNCR9EOy8mt5FJzfx4TwlE
	AlyGIk2jyhlYc1O5461g==
X-Google-Smtp-Source: AGHT+IEQTeDabcQv2edNrltRC5tMtg90HzgfUQmnYcrGIbH7A2aQ0yZWaO7/olruoMxEAQlNyMRZDg==
X-Received: by 2002:a17:902:d4ca:b0:294:f6e2:cea1 with SMTP id d9443c01a7336-29b6c571f11mr86250915ad.38.1763880756744;
        Sat, 22 Nov 2025 22:52:36 -0800 (PST)
Received: from rakuram-MSI ([2401:4900:9248:7aa9:d75a:8277:da54:123f])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bd760dbc99asm9716774a12.30.2025.11.22.22.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Nov 2025 22:52:35 -0800 (PST)
From: Rakuram Eswaran <rakuram.e96@gmail.com>
To: socketcan@hartkopp.net
Cc: linux-can@vger.kernel.org,
	mailhol@kernel.org
Subject: Re: [canxl v6 05/17] can: netlink: add initial CAN XL support
Date: Sun, 23 Nov 2025 12:22:30 +0530
Message-ID: <20251123065230.7869-1-rakuram.e96@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: 20251122093602.1660-6-socketcan@hartkopp.net
References: <20251122093602.1660-6-socketcan@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 22 Nov 2025 at 15:06, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
>
> From: Vincent Mailhol <mailhol@kernel.org>
>
> CAN XL uses bittiming parameters different from Classical CAN and CAN
> FD. Thus, all the data bittiming parameters, including TDC, need to be
> duplicated for CAN XL.
>
> Add the CAN XL netlink interface for all the features which are common
> with CAN FD. Any new CAN XL specific features are added later on.
>
> The first time CAN XL is activated, the MTU is set by default to
> CANXL_MAX_MTU. The user may then configure a custom MTU within the
> CANXL_MIN_MTU to CANXL_MIN_MTU range, in which case, the custom MTU
                    ^^^^^^^^
Minor nit in this description. It has to be CANXL_MIN_MTU to CANXL_MAX_MTU range. 

> value will be kept as long as CAN XL remains active.
>

At the moment, I'm going through the mail series. I would like to apply
patch series in a local branch and test with dummy module. For that
purpose, if I apply this series on top of linux-mainline will it work?

If not, please share the base commit details to experiment locally.

Thanks.

Best Regards,
Rakuram

