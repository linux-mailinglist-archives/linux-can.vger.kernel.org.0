Return-Path: <linux-can+bounces-7594-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2ItDKxivAWrXiAEAu9opvQ
	(envelope-from <linux-can+bounces-7594-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 11 May 2026 12:27:36 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ECB050BDD8
	for <lists+linux-can@lfdr.de>; Mon, 11 May 2026 12:27:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5504530037EB
	for <lists+linux-can@lfdr.de>; Mon, 11 May 2026 10:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A236B3BD241;
	Mon, 11 May 2026 10:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j0C5tr3z"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7112B22FE0E
	for <linux-can@vger.kernel.org>; Mon, 11 May 2026 10:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778495253; cv=pass; b=QC5T1fmEEPoU0QdhSbMp4QlzxbRZttfflk3L+Z77KD39wsUn/qO4e4LlRwJ76jdEbwS0U1BS8uWQWrht5l5S98J5dQrdKWL4nVinUu2F3jR45AKpw1oOKAOmySNgDQOOu38oVmN1kVgSGS3Y5bQHnTbxmOL594ephTKllLmXQqQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778495253; c=relaxed/simple;
	bh=6e1dCH/YTu6LMJOvFGE0lRfUBeCMINIq9HjnZFBGbqI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JO2l+cCVfmmrXyZtJtqwL3Q2t2jtz1nnpvoOH6UclN8657s6vgyIZ1rGiG196dMLIoXdeiJweADLbdquwp4XZk3Xc+g/+phSROQF+Gk7KS0phR4reP40OpA3EWAhhuF9tMhZC73V/fMUDlSMtFto5Cpy63hcSfGMaKhFii2ZdaU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j0C5tr3z; arc=pass smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-365cae89bf5so1735074a91.3
        for <linux-can@vger.kernel.org>; Mon, 11 May 2026 03:27:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778495252; cv=none;
        d=google.com; s=arc-20240605;
        b=ADmL+0ULCZLNcMhhz9TuusXJ1I29QMyxst6oD2NuFU5FIu6V0rxKH2YfagFJbm2+kp
         kvMQUo2mlulWtizvj7NOSDKjUwypzanMUj/wyl6HhG09OsgV2z5S5eluWtFZGLw4WfJK
         2k8iN6HkEq8AavQ20CaTarArOdsT8+tansK482aI2hV33fvGeUoeyaHJKV+5xH/1Fuv/
         Qtt6Pcq9JVAo+8AL5NRMgazgFHcdsXY/aJJvH47hP7Dw4Na/59v9YxyC3/KUS9pCbjmI
         6KLAPSk62h395let6ayJU63K7DvuR6rwZ0N5zYfJQc7vjB8VHD0xSytFeZBEAkKEwpKl
         QAFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rOjR5zbznVQFI6e4YboZd1K49D265gDKYhkZsTPiHvo=;
        fh=PZWsMiY3OpJXEEi1hekPsn7oT7JumRsSUsAhw+o0EkE=;
        b=kp7OeE0a6m2aWFwcxJM5191vCGh/4d+64L2PzHDsB0g46inXqAgbpMTBEXd5kIHVBS
         3F2rF7RbMjFjhUQPD5TFmnhsmNQciVqd5x+etaiH0qGuPZ7GwmA5m8Yxjkn6M+Bp4NkD
         HSOCLDpsrj4k3uO16MJPJ2AsoqlA4pA5cQzV5yV6sXD5o2oWaMJdftj4HRWSOx7VG131
         CrEyUz/l0FXA6WQhhNeAcqzgZfjEY56g2pBS+CkBAaSwHEe/r2HLTviTJH/pRwG2oqoV
         xIM0BAKFDDF6RCReVgvjh2wGBGUW6FNEw/9m6X94AB9Ge6jfiOIO75r8+/5MtBE/+l/J
         wQ5Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778495252; x=1779100052; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rOjR5zbznVQFI6e4YboZd1K49D265gDKYhkZsTPiHvo=;
        b=j0C5tr3zHwiWX/aDa1WNZ+hloKT288vmCV5bj9uKa8Kg8D3VOJvF3QOPH7tsoyJfCN
         2H/BfD+/daIYEFgsSPNZZmzFNGqHSm3T1cGzFlmhNhAVbXgDfF7sFbPenEZZLoRcFnul
         9LxEqydfP1Y3QOjJ6kXeIBDMNg3cC2TRSzLCfgSkxz9CS+iJB4RDbUkOO+l03HrKbZ3n
         ssR6tRvKFJZ751izEXIDxebQes96MeuzoATqUT2m0RlKG8FeeYowNV+iT6O71AwppFsN
         up3TmJ+2WVoB+UkDnWUnsHwW02AuRlFTjQUvqwg4rQpMxheEdyJpw5VQymPLZlVPVFFC
         vp6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778495252; x=1779100052;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rOjR5zbznVQFI6e4YboZd1K49D265gDKYhkZsTPiHvo=;
        b=nEbMwlRfV6yko1iz4p/wofHPill3y8F7BsvY9dKasOgXpOW4j4Y+GMeexwdnwgUVOA
         F9CzST7jT+ZqzqzShmgFtONOhJ5KcqsNOkjlxRC0ciay1O0OJbS4wg1PmoEPt87d+dQ5
         sJ+Pf+HS4+jBVM+RehuExvuRdq6LN6p7j2itCpUS/uo1LLDs9KE/v/Q6HZg+vilgcFSg
         dOoeRn2I9OyiRLPzWragwlCpLWn3Lvr+vykcq/WHxYTqqUm0V7kr9hcihJha95tsWa24
         h39o/4dQeeYQU9jbWf0Y9XPawZmmYwm+HUHV4OcaHKai0OARRfdZQ1KplVuEyhVh3sAj
         OICg==
X-Forwarded-Encrypted: i=1; AFNElJ+/B3DczW3iYdeMOgFyeJH9i7pg9RnXb4XRxOlT/sBMgPO0oERi2WyTG3RysTTmsPPX+s4zljRkVU4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNIMARHA8KSyW1f+0+do4gEgdTvHFOr2Ca3HaPu8IUMtuHqZM3
	yCbHCL4VkcbWdGJpBjQ50XGE4NTTugOtROb8JZpAW7FJuvB/BidAaCIWbZsPehVTMUxb79GDKYM
	3Vy/MjEgsS9Vc9Y4/DeatAeOPtuFKL4I=
X-Gm-Gg: Acq92OEClJPNZOXz+Wvkd2oAj6GBGDDmAYexD1ZCVnb2nkbSQnXNfdsQe15ZfLmV5iY
	6KnnapGQTbkQRmc6twEFsQnsNPfutjwm/8iL8d1ZkjDEE+XGvBPiJTokDzLheKO5/z9iOB3t7LM
	nei9NB6eFrMIuX19mh6UqnQB7VlYAYryXuIaIfGUSApP34xFzXPSoByI+79IexDv+9z9DuoixB8
	GlS7Ji3VK7dFQthfhAJ9s8z0Nm0EwnDps9AcyjYy5K742kb55AeEkUen1w8W+FhCqXFxkP8nkvj
	nOuaUKclh0XeFS39azhm5pKzJJII6Pk0DYDmoTMhXpG4lhti
X-Received: by 2002:a17:90b:2248:b0:35f:b572:ece3 with SMTP id
 98e67ed59e1d1-365ab3e6de6mr24593427a91.6.1778495251831; Mon, 11 May 2026
 03:27:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260504050702.34013-1-phucduc.bui@gmail.com> <DIFOSTNQW7OL.2MDUYPI8UXMBK@baylibre.com>
In-Reply-To: <DIFOSTNQW7OL.2MDUYPI8UXMBK@baylibre.com>
From: Bui Duc Phuc <phucduc.bui@gmail.com>
Date: Mon, 11 May 2026 17:27:18 +0700
X-Gm-Features: AVHnY4LHS-AZqmhw37kk0XA_N9FsecsRQTo4fOD-5_1WLrkqBJssh1lG_wIheAA
Message-ID: <CAABR9nFKz6f6idK4TG8MoYKAayqKDw3SySU45vTeryY79Z2yow@mail.gmail.com>
Subject: Re: [PATCH] can: m_can: Use of_property_present() for wakeup-source
To: Markus Schneider-Pargmann <msp@baylibre.com>
Cc: mkl@pengutronix.de, mailhol@kernel.org, linux-can@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 2ECB050BDD8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-7594-lists,linux-can=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[phucducbui@gmail.com,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-can];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,baylibre.com:email]
X-Rspamd-Action: no action

Hi Markus,

On Mon, May 11, 2026 at 2:59=E2=80=AFPM Markus Schneider-Pargmann
<msp@baylibre.com> wrote:
>
> I think this is a fix for
>   04d5826b074e ("can: m_can: Map WoL to device_set_wakeup_enable")
>
> Can you please add a Fixes:?
>
> Otherwise:
>
> Acked-by: Markus Schneider-Pargmann <msp@baylibre.com>

Thanks for the review.
I will add the Fixes tag in v2.

Best Regards,
Phuc

