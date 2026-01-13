Return-Path: <linux-can+bounces-6120-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E9FD185AB
	for <lists+linux-can@lfdr.de>; Tue, 13 Jan 2026 12:10:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 63390312839A
	for <lists+linux-can@lfdr.de>; Tue, 13 Jan 2026 11:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51FB138A70E;
	Tue, 13 Jan 2026 11:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D+Bh5Oh6"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E841389DFA
	for <linux-can@vger.kernel.org>; Tue, 13 Jan 2026 11:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768302044; cv=none; b=rWw21/L2mZksJX3n1t9AHP72PIkB/4qG07i34dXKnGuZS6QtY54GK155vU+FnZ/U/1hAdEDlLDecgUsIrKevVdJlpPT6TA8tJpFPj/P5/h7fXdFnzjs91HUm0Xaoo5cueoiieEXNToAvSFAcZd+5quzKMkgsEHxjcZa+DpYTr1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768302044; c=relaxed/simple;
	bh=LdtlRR/zPmyqCHUmYKVcI/xXnTeg7ttxnJWhu7f910k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=smlH1q/9pYFwm/NTkwqTxenxirMHIR/dMMSi9oJMAwRlLj1iDTafn2g06000Pfv2CzAAhz+BtkfN5I1AHcLwXvcG57BdcGiszodeyZCVD3P5CTYcK6dbl534ZjTswhC6TpGayEHW9Z/fgJH33chIImqvTFbQcvPomZXuQucV27Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D+Bh5Oh6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCEC7C2BCAF
	for <linux-can@vger.kernel.org>; Tue, 13 Jan 2026 11:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768302043;
	bh=LdtlRR/zPmyqCHUmYKVcI/xXnTeg7ttxnJWhu7f910k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=D+Bh5Oh6WOtBVHk8OQ5t1BFxhjWeaQIz40Dhd+qzuKREqTRitoebtCy1T+S+rc12s
	 q5DMV+XxrDayvqqt0Q5hrXbW1cicRU8CflxaiXJ3dp4ptN+cy6NWKjb/4VX20jkGwN
	 DVnJTIcXxk+4xaw0F8FijVNVKxJd1wf0lmtdOjvVeWdUcUR5G4Q9bcB1s15p1u6O04
	 YRuxp9uzG1JZ1GoTFt7iv6eHguX7idN3NdfcxOCRzdFS7ztoATD5CjVLa6OWj39o18
	 P9dYWX+nIbU2g++ePw4n0q0rM1GAHAdAvCLnlDdEcZEY8XeMJmS/v8oB0SmyWM24Mx
	 AQ4cAK4eO4Gwg==
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6505d141d02so11865799a12.3
        for <linux-can@vger.kernel.org>; Tue, 13 Jan 2026 03:00:43 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUwxWqgAYYzOHZ2Gmt9LU0rcZQTEMB62GwPpC09GLJ5ZJeS/pQNY5ZrP1xOINIW/RroRIDFSPMTuPk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDWyYH9UBK/ZflnrRCCZYGehJJEEXUs9UZ6qMw+azbouCkfXvg
	j2/MbgO0QeyYOodKh5ciYKtiLIQqHFRIXDxDUPTI9bXftQ+7mqtPQXgewivWB5l69SWWNLMs6fu
	xPyGxOVt6pQ58RetrPWD720//cO3k/UY=
X-Google-Smtp-Source: AGHT+IEPMuWdm/9+TjzNtsmM//veDgH/+XMFYCOMqiz/YLXeXEcfRnRUipeckAEUKaiXtiUzUtb65o0Y8vezFM/f9iw=
X-Received: by 2002:a17:907:948f:b0:b87:1dad:f71e with SMTP id
 a640c23a62f3a-b871dadfa6cmr624209666b.54.1768302042659; Tue, 13 Jan 2026
 03:00:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260113102718.1018804-1-oneukum@suse.com>
In-Reply-To: <20260113102718.1018804-1-oneukum@suse.com>
From: Vincent Mailhol <mailhol@kernel.org>
Date: Tue, 13 Jan 2026 12:00:31 +0100
X-Gmail-Original-Message-ID: <CAMZ6Rq+TtQnA-vvmfKhRftOuXyxWOPNZ4uH5ObT884OLDZHyng@mail.gmail.com>
X-Gm-Features: AZwV_QgAkYfVIWoDRGYqoDJbfRaao1Fl4wmTkiPwQztK7yc-e9UwzH4EiskYeYM
Message-ID: <CAMZ6Rq+TtQnA-vvmfKhRftOuXyxWOPNZ4uH5ObT884OLDZHyng@mail.gmail.com>
Subject: Re: [PATCH] net: can: etas_es58x: full cleanup in the error case
To: Oliver Neukum <oneukum@suse.com>
Cc: mkl@pengutronix.de, linux-can@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue. 13 Jan. 2026 =C3=A0 11:29, Oliver Neukum <oneukum@suse.com> wrote:
> Memory allocation can fail in the middle. Hence the cleanup
> needs to be called in every case.
>
> Signed-off-by: Oliver Neukum <oneukum@suse.com>

Have you seen this:

  commit b1979778e985 ("can: etas_es58x: allow partial RX URB
allocation to succeed")
  Link: https://git.kernel.org/netdev/net/c/b1979778e985

?

