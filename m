Return-Path: <linux-can+bounces-5825-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 987A7CAD82E
	for <lists+linux-can@lfdr.de>; Mon, 08 Dec 2025 15:59:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1055B306D5A7
	for <lists+linux-can@lfdr.de>; Mon,  8 Dec 2025 14:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9276319603;
	Mon,  8 Dec 2025 14:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GZcIpLjk"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5B41E0B9C
	for <linux-can@vger.kernel.org>; Mon,  8 Dec 2025 14:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765203551; cv=none; b=L14V2wla5ArVA3+eSMSKFvYIN7/HJ6j9YZRnIYvRDVROx/j8h+SjD25m09WGJf0kSOZ7HWLpAM2KfGTJr1dQYeKPXHfl53LU4yenkJzCco2xpUOQLkdxbmpcWUZzaajwh81wBLXikGABGhaFwA6nqVVYjTKWSaoWF0i709CXvsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765203551; c=relaxed/simple;
	bh=bAyGbNAjP4ciJGfV+RGobHZis/RzYePdIwxg5l1doqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PNnItb/lEUvflr+FnBFtUoXF8ytpnJmdyEZYv6jqxzqQ3NHnIumVpUUs/ix7ffZXIdmYhscmVFrzr/2coG+4I32kvieoYlcJWrXnqFIzeXkaZSEPLC70uo6wWv5z44ykUCBSnFtSYJ6bIJ4g6e8XWMJl7d3gUkzwwOBgrsGVjYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GZcIpLjk; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-343ee44d89aso5548589a91.2
        for <linux-can@vger.kernel.org>; Mon, 08 Dec 2025 06:19:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765203549; x=1765808349; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bAyGbNAjP4ciJGfV+RGobHZis/RzYePdIwxg5l1doqQ=;
        b=GZcIpLjkB1Q3eqJl8GywpfLargy5iIjvmcbD0ZRkLmw4uDb/WX0iSazvR3uohh+L3S
         HAnY8T+vD0l3iqNSEKMtbSHLFXTYuf57LUBfSeNTT1NJrQZo7aYa1wkLCm9IsiR+sCi1
         eOs557uM3KvUkRU1YNdWlCFlxTjcMoef0QxwW8vOjQa/0pIA7uPLWCabBFSPJywH4Svw
         TPOyxjvXbUoXuHo/uuAEGC+z9FGuGW5aGsIs2SKT0VpC/sJOmytgGB6+VwHqaIBWZcYs
         L/pCoItt/TPL8kbfPlldDMIeF53WB3m80vhRw3sQlT61Fald9xH1J64G6+4Y+XlBhqgE
         9QpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765203549; x=1765808349;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bAyGbNAjP4ciJGfV+RGobHZis/RzYePdIwxg5l1doqQ=;
        b=GYTx2YpvTq+RWj4iSGldjrTtpJSmG/YrsnVZ3pPR24K5aaJ93be62cDXFVj66XkVmr
         40dxiv6BaxHIVRIKLV/WZlHbCIv7hsX8MmVXZp3nQ14XGmXWLcw9FTbTStsf+bVqOEjK
         e/liDldP1YMf8Nr4ycrKXmYJkxHWVL9vBaRWlCmAVxUMxPDj+GqylEmz1o4kFo4MT1s8
         zMzP0O4KmwwoTsV07n27GA7kO6W0iQFOoMzbu8SDTR83HXHaHc/pY+kJwAaFSpHCNBjv
         70c6H5fE1qmKkDRhMePvXqySPy3m/QnsPx9qsRvgMZOITRnE84xrlvkhf7/CmMUwduVr
         6ZPQ==
X-Gm-Message-State: AOJu0Yw2k1aC+GlloLrri5KG4MmruoUi7uWThZfbKJN+lGhJLkqb7jd/
	LW8kC+1muhaT+c4CaItV2T3HZwONa3VhuCKpjrToYABTbTliTx52moSjipe8fbIF
X-Gm-Gg: ASbGncuVqUce1jef6KBPVE5kZPB+Z69SOMjSg3NjrWY3YIoET1XH33vna/jEbuo4ctt
	9gKjljBPYX/5I+HlSoa6ydFCtgWzxbkmivDgepGI02nMHB6hfC8hImZ86GtDEEoIcC8L6owLATr
	9VcCQvtxZxD2Vlmm1PZLz9KVJZG7qpr+DtsdW229baw3uTvbCCsv2OM8eLxXn15yKVuCToRT36/
	CL+5FqEF9wS+qxI1sM5fUoxNxrvqROp+8FE3S52MCH70vvSEpw9OF6aw0H2uT9881zUn3C5fGa+
	asVMe5Vd9IcmPqhyDPH54HnQxd2kRAJK505jtfWpuCXcpn/dU8aKFQ1cH3/FksbbN40v9ApD2jc
	dMwfA0URSPLmzWtZHK4YqCTz3BcDtOLy+bwhyWrLdzSvI6G7XlH318IYpq6bw+ayoxcrgwBlWjQ
	+RLT5TqjrvFNfiT2Qu
X-Google-Smtp-Source: AGHT+IEAWNoOqTDFnhN4eM4XE1SRsVgEFHOOYSD5tnAsTXRycFLHBhdpxoMgU2oFGHTPkonW8YIXjA==
X-Received: by 2002:a17:90b:3a90:b0:340:f05a:3eca with SMTP id 98e67ed59e1d1-349a25bdf87mr6616761a91.20.1765203549007;
        Mon, 08 Dec 2025 06:19:09 -0800 (PST)
Received: from rakuram-MSI ([2405:201:d027:f060:7cf0:6715:586a:9d66])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3494f398f8bsm12112025a91.7.2025.12.08.06.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 06:19:08 -0800 (PST)
From: Rakuram Eswaran <rakuram.e96@gmail.com>
To: linux-can@vger.kernel.org
Cc: rakuram.e96@gmail.com,
	linux-kernel@vger.kernel.org,
	mailhol@kernel.org,
	mkl@pengutronix.de,
	socketcan@hartkopp.net
Subject: Re: [RFC PATCH 0/2] can: add dummy_can termination and update SocketCAN docs for CAN XL
Date: Mon,  8 Dec 2025 19:49:00 +0530
Message-ID: <20251208141904.8737-1-rakuram.e96@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: 20251127191808.144723-1-rakuram.e96@gmail.com 
References: <20251127191808.144723-1-rakuram.e96@gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On Fri, 28 Nov 2025 at 00:49, Rakuram Eswaran <rakuram.e96@gmail.com> wrote:
>
> This RFC series introduces two changes related to CAN XL support:
>
>   1. Add termination configuration support to the dummy_can driver,
>      enabling termination testing with iproute2.
>
>   2. Update the SocketCAN documentation to describe CAN XL operation,
>      including MTU changes, bittiming/XBTR settings, mixed-mode
>      behaviour, error signalling, and example iproute2 usage.
>
> The goal of this RFC is to validate whether the proposed behaviour and
> documentation match the expectations for the ongoing CAN XL upstream
> work. Feedback from the maintainers is highly appreciated.
>
> Base commit:
> commit 30f09200cc4a ("Merge tag 'arm64-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux")
>
> For testing, this series was applied on top of the following patchsets:
>
>   * "treewide: remove can_change_mtu()" (Vincent Mailhol)
>         b4 am 20251003-remove-can_change_mtu-v1-1-337f8bc21181@kernel.org
>         git am ./20251003_mailhol_can_treewide_remove_can_change_mtu.mbx
>
>   * "can: netlink: add CAN XL support" (Marc Kleine-Budde)
>         b4 am 20251126-canxl-v8-0-e7e3eb74f889@pengutronix.de
>         git am ./v8_20251126_mkl_can_netlink_add_can_xl_support.mbx
>
> Testing was performed using the iproute2-next tree (canxl-netlink branch),
> which contains the required CAN XL netlink support for validating
> these changes.
>

Hello,

Gentle ping — any feedback on this documentation update patch series?

Best Regards,
Rakuram

