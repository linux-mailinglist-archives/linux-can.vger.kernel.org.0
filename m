Return-Path: <linux-can+bounces-2211-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89A7C9D864B
	for <lists+linux-can@lfdr.de>; Mon, 25 Nov 2024 14:24:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E402B28370
	for <lists+linux-can@lfdr.de>; Mon, 25 Nov 2024 12:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF9A621106;
	Mon, 25 Nov 2024 12:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=formulatrix.com header.i=@formulatrix.com header.b="tlU6WU0r"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB3D188015
	for <linux-can@vger.kernel.org>; Mon, 25 Nov 2024 12:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732538780; cv=none; b=jG6mnjwXw4dC7FkaXZhd6mGNyZtTflKbqE1vEYZyl+7AkKGHdX/knIlB74G+lmvGhRDoFLyrG9UJaGIoVIugcTIWvoEM9SrFE+2+sreomC+fCXzUXe7lP42WCsJC+y7BGBXUCiRVlaMoMS9UmI9voO5BsGBpPOyUaYK2EAaTAsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732538780; c=relaxed/simple;
	bh=BvAQN4YC29SAYxWmCPP0356KXZZ265Xen8KYFjz9NvM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KysdFOCqeu+cKvHosS/C9FoIMaPjY27i/6oaEhZ3+N0jwOLpjUBuytAv3vLAmxhoTtPWdfs1UTUFpcS387W4GK9iic0e5O55nT3bXlPc8WJUKP3ASE8LRWoNTFY2PM8ixdpgR5/K72PWnObMwSm5/zx67Z2mEDQfMiNaLoGs3Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=formulatrix.com; spf=pass smtp.mailfrom=formulatrix.com; dkim=pass (1024-bit key) header.d=formulatrix.com header.i=@formulatrix.com header.b=tlU6WU0r; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=formulatrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=formulatrix.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7242f559a9fso4278369b3a.1
        for <linux-can@vger.kernel.org>; Mon, 25 Nov 2024 04:46:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=formulatrix.com; s=google; t=1732538778; x=1733143578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BvAQN4YC29SAYxWmCPP0356KXZZ265Xen8KYFjz9NvM=;
        b=tlU6WU0rlDdIrDwBcSsCcyWQ17X4c4oiRu/0F3g8V7fpn5RBef+Q27f9EJFW93CDgr
         J/y+B8GxnFGhB+PwOF7KNExblaZcZvFje7gj+nI+a6xSPr2KtYXvvhmQSgr1nldWL8p2
         UhCxY1SOPzaR8yp6EFdQ9r2vsQiHJ8CBCb1Lc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732538778; x=1733143578;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BvAQN4YC29SAYxWmCPP0356KXZZ265Xen8KYFjz9NvM=;
        b=TChP5vzZoYh7zBxgxl4HZAqplA0JyPoY1on96/WUBSlWZjVOmL7TFbqDXTCA8FgkIP
         g4qjebcmAZABn0dwlAJfgZ4avB1fO/Lgbst1l0Q0lPZh35YLHbgcgX2+3CSCaf2yMvbq
         rPPC3XsP297PrfYsBQVpb22xxopHcdL132VDN3evIKSpJBQ2XBQrey1VZzG+QUnaxKdV
         JeqwG/Fayh+PVtXXhP2YgATaKIIk4AWB6x0/trz6/kUUrJzd7tW4/cl6Ik5mldkfh8aM
         rgcL+nkqlRdJJJ6grLXPjCP1oqTI9WiES1nQ9k12AdUg40gjJFHwqDv4KZsXFrG5bF0S
         h5PA==
X-Forwarded-Encrypted: i=1; AJvYcCWuP5CS7INcduGEvDdQu5vNkf6SYzFRKxHDmu1MQptalBpXS+1tW+hzSoNObaRaR2gGGoO4nv/81YU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYkHaTbLmyVQsCOyWMEUfuMqepgBuJcvzOcyx/6E991CcAca3F
	sI9GHUoxRRy/lW3JU+vpPKCRyCYhUAP5weJF0SlQdSuStSdHD0jEKQpBrgCdkw==
X-Gm-Gg: ASbGncvu8Pj+O9SjuT3DfAn5nyhtzV4Se9EqZG9xL6O7VXe62ZpR3XodoOcV/ZeSXJQ
	4SWbif56R3PB+coZAlYTjVVtgGJsuwgCOh/HXpkHq7PPNyErrpEa2T0LgZkAkM5ZfIW7CfhWYKT
	VAqi8cGfpmEbyVPGmvAiBWUjNoLTJpkmiEnzmUg7oVueu5HJ0pCh99zUzcn6mYnsRsxSGLKZUTs
	b7AXMOYfIGgsWEqt+KS6GC6bYUWhHP8qW0OoMEtZegf1R2lMIhIJ+ORgWh69mbszBgrx7qr+MwB
	VvRxZO8=
X-Google-Smtp-Source: AGHT+IF4YuEMdiCzruCGL/fEjGoaDZJgPmIaqI8VzgC22qkArn7lOoJ+CUDZHvBHXkOmiLHcD5ksBA==
X-Received: by 2002:a05:6a00:9a0:b0:717:8ee0:4ea1 with SMTP id d2e1a72fcca58-724ded24deamr15030649b3a.0.1732538778612;
        Mon, 25 Nov 2024 04:46:18 -0800 (PST)
Received: from SE-151.formulatrix.internal ([103.12.224.66])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724de4795f9sm6306778b3a.50.2024.11.25.04.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 04:46:18 -0800 (PST)
From: Renjaya Raga Zenta <renjaya.zenta@formulatrix.com>
To: mkl@pengutronix.de
Cc: kernel@pengutronix.de,
	linux-can@vger.kernel.org,
	mailhol.vincent@wanadoo.fr,
	manivannan.sadhasivam@linaro.org,
	renjaya.zenta@formulatrix.com,
	schuchmann@schleissheimer.de,
	thomas.kopp@microchip.com
Subject: Re: AW: [PATCH RFC can v2] can: mcp251xfd: mcp251xfd_get_tef_len(): fix length calculation
Date: Mon, 25 Nov 2024 19:46:13 +0700
Message-ID: <20241125124613.29162-1-renjaya.zenta@formulatrix.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241124-fervent-unyielding-macaw-1c66fb-mkl@pengutronix.de>
References: <20241124-fervent-unyielding-macaw-1c66fb-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Marc,

On 11/25/24 6:01 PM, Marc Kleine-Budde wrote:

> I've just send a patch [1] to work around this issue. However not
> tested, as I cannot reproduce the problem here.
>
> [1] https://patch.msgid.link/20241125-mcp251xfd-fix-length-calculation-v1-1-974445b5f893@pengutronix.de

I've tested this patch and it no longer crashes with the previous reproducer.

Thanks for the fix and detailed explanation.

Regards,
Renjaya

