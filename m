Return-Path: <linux-can+bounces-1847-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C628C9B7A11
	for <lists+linux-can@lfdr.de>; Thu, 31 Oct 2024 12:55:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B59EB21736
	for <lists+linux-can@lfdr.de>; Thu, 31 Oct 2024 11:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB8E8199FCC;
	Thu, 31 Oct 2024 11:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="juidbRsA"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E81153BC7
	for <linux-can@vger.kernel.org>; Thu, 31 Oct 2024 11:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730375730; cv=none; b=g3gOqNbhB7Y5LWSJ7KmOGKFZ4/eUWmlv8nvRrN94vsFPeRHcL7b8zleqwqIlJjuxvfuIgeVrA2+wtms88UBqSiDJz+FGJUKFVlBizFXkeVxsMBu2twcDTwp7TnCZMlDdEErumMS1JJ5ln70SYWjkZG39PWAnRWoFmHnxuzL4/CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730375730; c=relaxed/simple;
	bh=rBWHHGIBKG7aWGjy5o2LvySYQiy7eKFw8FuN7KLS0oI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=aVpEn4Mb1Lcy/qBLbVPbJFMDUidynGh3W01vrQTPkazJg6tGEf1HLEYbPxrhoJNcXAhLYu1q2Xw8r+fCyHCU/W3YoC8rGMEy7jYpshLuALxlhXPSqOa6tETfajIRgtLuA1xq3VYwmec0s+rdhfe6mUGzHSuIs1Y7KS4dJiQT9iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=juidbRsA; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5cb6ca2a776so1186478a12.0
        for <linux-can@vger.kernel.org>; Thu, 31 Oct 2024 04:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730375727; x=1730980527; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rBWHHGIBKG7aWGjy5o2LvySYQiy7eKFw8FuN7KLS0oI=;
        b=juidbRsA9MRDmYACPHJSmbIGXt7IlbdnGjxeJUIFVDH81jLxswt1spYaN62sL0OPpf
         BxfjbUfc5UgxPgBeRcr1wpfnoki1pkeX2j8l3FRYrHpMYCXQS+ghkZxxxzTIiedV6ViJ
         yQIu5MeSEVovMfTkSLAoHZvycVN27843SLPjCe1uhCXyBIQmUWC0xWqMGiS6G5Fejz/K
         SsqG4DSdVEKZ1aD5by6vkHfX0AL8HMWQ/Jp2y0D6b6Eo/IuaWZ+6b6j6C1pOPIG3Kpjc
         6O/5repMpx2BFlRkAZeXfjjG0wohnw+QW5zNaXoM5LfxVpOlRS99PQ+mrbwGY1rCVyrF
         /Aiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730375727; x=1730980527;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rBWHHGIBKG7aWGjy5o2LvySYQiy7eKFw8FuN7KLS0oI=;
        b=OpA+9c4xyIOJ9xqxsNAzDobCp6UGzRULZBno+CB89/loL3ynvDuoahAClVSlqFLFpU
         PorbKOBYo7pUSLXeA2jC3UYCy7DMcff/YUcM6Kg6foABlncTdHL9QeKfUfAnlmWUuSRy
         ZzXvh2QKzaC0M69K7l07JE0r0rmcV0aSuUUvjDJ1jmcpXbMlZT5S0THmq2Su96pnszSq
         0hqSIGd7bDaZwDahIGXJvwrNRjgG5nGipKm3qozQ5c3P4+lOUgqhr8WDWrSxHPkr8rOn
         thyBXO6zIgZHHiY6lhvL9VFqm5WbsuKDWjnfAenqbTXNndTOxTd6Gtzsfk93UtvPUvT5
         1gTA==
X-Gm-Message-State: AOJu0YzY0n+4/+YGi/+EXtMP2HO2msyYOUQ0ZmlLS1c5JtVjs6KDLFra
	eZSrpRsPrH0LljqxmqmYIH0CPNfgSHJiWpU8JSmbURh5qRS4Djql5jn3tUSB5TrNYY9PCNm5nrE
	Sb5XIZYQwpi7JuRS/XUj/K2evZ81mFFbDoGQ=
X-Google-Smtp-Source: AGHT+IHDI2Qt5N4+fNjPDol62mHT72ORWi4rUlHemvGlamonbgAInoDEvitXy9wAKqfSgec+G3flxURMRL8yLafHenA=
X-Received: by 2002:a05:6402:5242:b0:5c8:8bde:a1d3 with SMTP id
 4fb4d7f45d1cf-5cd54af0e79mr4250965a12.22.1730375726030; Thu, 31 Oct 2024
 04:55:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Robert Nawrath <mbro1689@gmail.com>
Date: Thu, 31 Oct 2024 12:55:14 +0100
Message-ID: <CAEQ16vpxthctdrpv0kBKEZJA8VNYffjGGPBGBY93RmKDD49bAQ@mail.gmail.com>
Subject: Missing CAN-XL XL data bit timing
To: linux-can@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,
I'm working on a kernel module for CAN-XL device. I can see in
/linux/can/dev.h that there are structures and methods for setting
bittiming and data_bittiming. The bittiming refers to CAN nominal bit
time, data_bittiming refers to CAN data bit time (using ISO/FDIS
11898-1:2024 nomenclature). But in CAN-XL the data bit rate has two
values: FD data bit rate and XL data bit rate. This values are
different and the device shall have separate configuration register
sets for them. So for separate configuration registers there shall be
separate methods and structs.
Am I right that the current implementation in kernel is incomplete? Or
am I missing something?
Robert

