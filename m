Return-Path: <linux-can+bounces-5880-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 281CDCCCA98
	for <lists+linux-can@lfdr.de>; Thu, 18 Dec 2025 17:11:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C320F30B8150
	for <lists+linux-can@lfdr.de>; Thu, 18 Dec 2025 16:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC15C38259B;
	Thu, 18 Dec 2025 16:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mh62hGMb"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613B9382BC2
	for <linux-can@vger.kernel.org>; Thu, 18 Dec 2025 16:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766074000; cv=none; b=W5AXXY+SsBCBbwUrNMlBrqw6wDboCHp2/C0CX4QVvdGosR/Y4fId2a3TLLWRek/nW7YZQDlBgomqB2pqQnbC0/BmtpalL08hYxrCbLVqUdIfNIk+mJav3TAJ3muyLVIj7l72DgO4hEzGAxNm0sluApkwFC6uy8ahQeU20LSNDNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766074000; c=relaxed/simple;
	bh=N/+tNrUhoVmHyefQGiqMlVTM1fjcGnJA7imeslwrc1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QhmMY/kRt03LVmfFDNqeGkV2fpvjKRGqGT/lRknTefsxHvCPv1pLe5Nz0uxlZsWqGDgy/q5E66ogn7bWD0L6EQ1AeDvAdI+mvxy3Spd4Fi9Gy1+RZbZxKEcOvlAiOvOAdlGoXausiBSV2f9JdXoHEzuZ6zPeyXKd53LeQzCSiAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mh62hGMb; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7b9c17dd591so737892b3a.3
        for <linux-can@vger.kernel.org>; Thu, 18 Dec 2025 08:06:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766073997; x=1766678797; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r1F7rdn4mQHpK3iza20y4glJuCv0KzYHM6zaO6Rnyo8=;
        b=mh62hGMbAkYSoVLCBDRw0be86rRhEPdDu9Q1BwopSaunzWoDPpKUzd6h2DLoLlzCIx
         E0Xrdwps7wkjYw1eiv0zOLi6h35dEnfR8zYHY5IdLHFg5AKtqAM/5YW8/yGpxdzV+Hpc
         vknRnwXN/yv28gVLvGpLMrLvXMQR6ACj13zfubUj9oBOb2mWrYrDWY8TBombURfLfmWe
         AOuaqoTdHRyEBTLkg+PosBMbXr83nMA+/UqAbV86GXa7LWlHecgwYcsl+HaVWAXn477c
         TisU+sT6Ze/aOaFttSnNv6/+jD8j1yLcnr3yziP421FRWlpBOlAsughyf4YaQlFa75hp
         sWgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766073997; x=1766678797;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r1F7rdn4mQHpK3iza20y4glJuCv0KzYHM6zaO6Rnyo8=;
        b=k++8My42jbVaoE23cjfQiSL2Q31XuFBFrGZseGd1Z2B8sbH7M7CHNOBK46GWEOHwbc
         0i/vvAe6QgtL0uKeodxtQnXcyO9/oDnn3E89MHpSGH+InyRvWYVYtJ+RhbgPLDNwA5Qx
         ahlVFpb+KE3xH9Po7Mk5bMkeFHrRFnA0RL0s4+fdOpEWU+H1gxhTLmV1SwYo1m2asvxY
         gzSsB0Mi0lznHnjJcAg6SW8NhurrC8uHx1OEt5A2jfDnmWrtozZtv/18du71jia2WdA7
         c1Npka/Zleg8lMDNFTufXwd7uW4qDdTT1hZqr+QKQc9IkzcGuiGUyI36Af1zdEndGgop
         947A==
X-Gm-Message-State: AOJu0Yy0oGCVOPvneuxZjG7TOY796D9zf2Fl57WHaTolIHVsC7gjqRAK
	vgMXRFGj2FDLNnKLFLaGJOlK1HRY0qDtmMiBachoOIQV38dXOssiJ9e769T2nA==
X-Gm-Gg: AY/fxX6hx5wXGqeCgL6er4L0D3l4+375XT8/86ATt9ZSR5MR9tDUgC491zqgrFSGM0U
	8PSKHgqhqTuTMyJr76oZSfX0SGChqQb15EVRVXWsUW7Aw+Dq8Nyd/JU+kx01dkWtToQjXVK/2AB
	cQpfi/YxevqJSj/cy0SxBb2VgZtAgC0KeWlWTLCRTq6kw7656jtChBjV6KrSXPT4RO2MBD5oDa9
	kqlvifgNOcEsCJzXGS6CTUfdxdHhHYy5zObR1Ve2T0u8MmK8Sxt+cLf8tPHxo5+fAK+sOvueo38
	bAVCO9zv4+CFk8WKlLqyWn434+2z6FeZh7p29tc54cDu/S0Mhip+g1OYM4giUMFo7+G7ElMRSFq
	zSWOKr5LSxPH7oegi4FkkaA0ZwcOymrX2zj1/5p9zZ9PsTWNGK6C8TqZX2yvbar+h0xrSs9wCqT
	A5mBphAx4ZfrUDa/BL
X-Google-Smtp-Source: AGHT+IFDJW6swj2BKgRpwfquptQ5uibL5YVJTsgBXdBc1Q8r/bal0x4qxcZUbmhF6KBjdZNO7W8oYw==
X-Received: by 2002:a05:6a00:4c09:b0:7fb:e662:5c8 with SMTP id d2e1a72fcca58-7fbe6620b62mr9382372b3a.30.1766073996561;
        Thu, 18 Dec 2025 08:06:36 -0800 (PST)
Received: from rakuram-MSI ([2405:201:d027:f07b:544e:d191:619b:b44a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7fe11856ec1sm3024195b3a.10.2025.12.18.08.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 08:06:36 -0800 (PST)
From: Rakuram Eswaran <rakuram.e96@gmail.com>
To: socketcan@hartkopp.net
Cc: linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mailhol@kernel.org,
	mkl@pengutronix.de,
	rakuram.e96@gmail.com
Subject: Re: [RFC PATCH 0/2] can: add dummy_can termination and update SocketCAN docs for CAN XL
Date: Thu, 18 Dec 2025 21:36:26 +0530
Message-ID: <20251218160630.7862-1-rakuram.e96@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: f33bb7a6-75c7-4ee4-baae-755ff25d81d6@hartkopp.net
References: <f33bb7a6-75c7-4ee4-baae-755ff25d81d6@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On Tue, 9 Dec 2025 at 21:47, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
>
> Hello Rakuram,
>
> On 08.12.25 15:19, Rakuram Eswaran wrote:
> > On Fri, 28 Nov 2025 at 00:49, Rakuram Eswaran <rakuram.e96@gmail.com> wrote:
> >>
> >> This RFC series introduces two changes related to CAN XL support:
> >>
> >>    1. Add termination configuration support to the dummy_can driver,
> >>       enabling termination testing with iproute2.
> >>
> >>    2. Update the SocketCAN documentation to describe CAN XL operation,
> >>       including MTU changes, bittiming/XBTR settings, mixed-mode
> >>       behaviour, error signalling, and example iproute2 usage.
> >>
> >> The goal of this RFC is to validate whether the proposed behaviour and
> >> documentation match the expectations for the ongoing CAN XL upstream
> >> work. Feedback from the maintainers is highly appreciated.
> >>
> >> Base commit:
> >> commit 30f09200cc4a ("Merge tag 'arm64-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux")
> >>
> >> For testing, this series was applied on top of the following patchsets:
> >>
> >>    * "treewide: remove can_change_mtu()" (Vincent Mailhol)
> >>          b4 am 20251003-remove-can_change_mtu-v1-1-337f8bc21181@kernel.org
> >>          git am ./20251003_mailhol_can_treewide_remove_can_change_mtu.mbx
> >>
> >>    * "can: netlink: add CAN XL support" (Marc Kleine-Budde)
> >>          b4 am 20251126-canxl-v8-0-e7e3eb74f889@pengutronix.de
> >>          git am ./v8_20251126_mkl_can_netlink_add_can_xl_support.mbx
> >>
> >> Testing was performed using the iproute2-next tree (canxl-netlink branch),
> >> which contains the required CAN XL netlink support for validating
> >> these changes.
> >>
> >
> > Hello,
> >
> > Gentle ping — any feedback on this documentation update patch series?
>
> Many thanks for the patches.
>
> The termination patch should be commented by Vincent, who is currently
> pretty busy.
>

Understood. I will wait for Vincent’s feedback on the termination patch.

> But as the next merge windows is far away this can be managed in
> January. No hurry.
>
> The documentation is almost fine but still has error-signalling in the
> ip options and there's definitely no xl-cc-len16-dlc option.
>
> Please use the latest iproute2 code to generate the examples:
> https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/
>

Acknowledged. I will update the examples to align with the current iproute2
tree. I will respin the documentation update accordingly and plan to send the
next revision in the first week of January.

Best Regards,
Rakuram

