Return-Path: <linux-can+bounces-941-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B1B4D91EDF9
	for <lists+linux-can@lfdr.de>; Tue,  2 Jul 2024 06:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F87EB2154D
	for <lists+linux-can@lfdr.de>; Tue,  2 Jul 2024 04:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A6581F;
	Tue,  2 Jul 2024 04:52:20 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1223211
	for <linux-can@vger.kernel.org>; Tue,  2 Jul 2024 04:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719895940; cv=none; b=ScMaaTb4XwbQbys1VsmMHE55RYBKfmoeKN6DGZr9pO4UGqx/ubXw8c3GV/sR6nNTI7fEtkPhp86jbrpyNy9lPucOkw5cVRNSeJbPCXIMzssSDlq70Fi7FDS9GB56/egWgm+QnjUw54oGc4ox1z9h5UHaVkiBPs0l7wnmX2KIu0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719895940; c=relaxed/simple;
	bh=gaUXrOnzHygVU9jleDWDup8+BgafRdtoZQf2wTmEQpg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=utDZFfV/QnWRObZrQIdD9Da8GH0jRZmYj5sL9bGmrh775vx07QMIZPghcjL9CSgFTzGzDWg/5l0ipKA1WcAmPyPRsqTDbi1twZPfFYc9mW0Ol6X07qLnQKcBJ/dwtc7NNYozxcUPNQaquJdL2zJYfQTE2wQxtf8pD9ERxV6GqLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-70aaab1cb72so2289638b3a.0
        for <linux-can@vger.kernel.org>; Mon, 01 Jul 2024 21:52:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719895938; x=1720500738;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gaUXrOnzHygVU9jleDWDup8+BgafRdtoZQf2wTmEQpg=;
        b=cC32J79fCy2KpLb2Jzjv+NpvoDUcFukgo98ePDMv6UFNF3wdIR1k8f06cR0mUkDXrH
         W78zVXQTdHHjs9HSQp8H2t2fMty6WrMWMyyIwmVB3b4j+HrnkN2vZHUMG26cPdk3samE
         MS0r4Q4/UQUfcYVp0XIdlUt2s/uFWTq4MRmNL0uIJenltrdXEHxTNO2WfaHxf5BeeRE4
         KmTuz20fI1KdrEO2IWfUOfv4O1VCAN+yrNTQcorMuZA1E3OR8WPHDOQ2jxNJ2b3UuIF4
         l6/YDKDc25wtZCjHmdq+Ax39Q/VFNvNuigBEbOT059shzNxV7KEAMFxDECOIV47ZRIHi
         HWEw==
X-Gm-Message-State: AOJu0YwHgUnyG9Vp3JpjpwHxfwmdYrSMtfWgzKGRBLux4dXVn/l0STfW
	YvIRJ5wtycCZcOIyUwq1xD8xf2lAORUd5RfZGrzkSyrLp+aSuJGHhHio5xuWVxFDyBre1Vh51h8
	13/X+WrmgLCJW7cWZCD3lUbRYjVI=
X-Google-Smtp-Source: AGHT+IEln1N5xmxhKYORYyDtx3QrdEJy+MvdGnqRuCbH8lvrFY8VwVQlYiqSFNapwfFH1IuSr6eCHut1f4qmsnWE1DE=
X-Received: by 2002:a05:6a20:2587:b0:1be:c6f8:c530 with SMTP id
 adf61e73a8af0-1bef61250afmr13353848637.26.1719895937514; Mon, 01 Jul 2024
 21:52:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240701154936.92633-1-extja@kvaser.com>
In-Reply-To: <20240701154936.92633-1-extja@kvaser.com>
From: Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date: Tue, 2 Jul 2024 13:52:06 +0900
Message-ID: <CAMZ6Rq+s23=UEokgGjOPy7tHg6CsgEuehr_nXC948s2Vt8Hm5A@mail.gmail.com>
Subject: Re: [PATCH can-next v2 00/15] can: kvaser_usb: Add hardware timestamp
 support to all devices
To: Jimmy Assarsson <extja@kvaser.com>
Cc: linux-can@vger.kernel.org, Jimmy Assarsson <jimmyassarsson@gmail.com>, 
	Marc Kleine-Budde <mkl@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"

On Tue. 2 Jul. 2024 at 00:50, Jimmy Assarsson <extja@kvaser.com> wrote:
> From: Jimmy Assarsson <jimmyassarsson@gmail.com>
>
> This patch series add hardware timestamp support to all devices supported
> by the kvaser_usb driver.
>
> The first patches resolves a known issue; "Hardware timestamps are not set
> for CAN Tx frames". I can't remember why this wasn't implemented in the
> first version of the hydra driver.
>
> Followed by, hardware timestamp support for leaf and usbcan based devices.
>
> The final patches are removing code used for selecting the correct ethtool
> and netdev ops.
>
> Note: This patch series depends on patch
> "can: kvaser_usb: Explicitly initialize family in leafimx..." [1].
>
> [1] https://lore.kernel.org/linux-can/20240628194529.312968-1-extja@kvaser.com

Thanks for taking care of the TX timestamps!

I left one nitpick which is notwithstanding. With or without my
comment addressed and for the full series:

Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

