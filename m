Return-Path: <linux-can+bounces-5638-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6210EC83655
	for <lists+linux-can@lfdr.de>; Tue, 25 Nov 2025 06:33:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CF4F934A0C2
	for <lists+linux-can@lfdr.de>; Tue, 25 Nov 2025 05:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 186251A5B84;
	Tue, 25 Nov 2025 05:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QBnMlRbD"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CCA019E839
	for <linux-can@vger.kernel.org>; Tue, 25 Nov 2025 05:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764048815; cv=none; b=mMkF8dLKkgliHJPhUWzGc4YSafBqxbIM4YKh6xGQTPRXIjhMiDRCeYC8o9xB87nhPqePY+Lh3IJTQNivAgazcnI0mTDAz5jVJeWQRk37oDXZiRuibGfl1wMDom4+bE7tEU7NhFtNsZyI9JsaSbSSLxG7vjZfxiRbFcDNT+wh6JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764048815; c=relaxed/simple;
	bh=aWqxgD4KuCvcLixyOk4q/hMJm62d64S1lTnIC5tgJAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hvcmb8YNMHW7olzxndUmUKKmXtY4QfMj14Kx1Zas87MrDlaBRFIkgw9HcnVV97zYqyMLBBP1WjCjU0QijDcWBrYsHdhQ8tZPDAb1siyEkj3iUYs7KuA/TYhoFa7FtBKPE2tam6uG579c2pCg05LknvHHQDCs1YBO98o5Ac5LZYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QBnMlRbD; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-340bcc92c7dso3501003a91.0
        for <linux-can@vger.kernel.org>; Mon, 24 Nov 2025 21:33:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764048813; x=1764653613; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F/PsBAvfbZEDwnZsJYh1xV38haTycRmkAZhbocASvl0=;
        b=QBnMlRbD0cd7IrzrZAE2N3YpgMW2bVSeW8KdLvwdhj8AFmHVLZBKnsd2GO4ET3kqaA
         ClJXkFjETlyj96tSp5l3xWuWjUOle02Jc/vE0ZGtdm79T03sT8OX64+MdVa+Q2gnvLrm
         YrHZKp8OMWrEOb3214JUlv00nqrdetKvdQXksN2Gda5uL2bdMfQiQ7TfHw21NXaDmiOc
         VE+Qjydete5iZ6MtHoPX9SN5tyE8begxgnmK4svOWN4Xpb1QA+d0Z8gMJTVU9zyzhASL
         qo1sonjmiZ+Gsi4hO7ENknog3q1zH6tZhH4c/9pp5Ziuef8GdomBrtNhLNI9Q3c40qNF
         OoCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764048813; x=1764653613;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=F/PsBAvfbZEDwnZsJYh1xV38haTycRmkAZhbocASvl0=;
        b=D1pUhmryHGq7IVeh4sHrezhkMPuJFdy01OPeBLcYWzbZEYQoh+p5LXuskU/OXDdMyu
         17B/0S1uJG/eGI7msVNFg/5iE28Ie3qJGiSPOEpdZ8VGSsAqjAoAfqhl0+Egw7hMQvk7
         /ug7HiHl+bkx2ZBByzwJ1e2M/UM7cDzexMOMAtqbTCJJ9rNShUEVdbjCXoHLz5NYXeoW
         abnC35pmmDzj4JKQlOKoMGu4XqaADfOOY0e+Vb9hXj62Eu6pnOqI+220uEfZkUnP6/dV
         Cf1+d8Ue6eP+Jr2IJoP82pd+aTLYXZSMApOdiY7IqJyATFWLZHb7v5YQM6CvvaKA/rMs
         XoUA==
X-Gm-Message-State: AOJu0YwM3njgAuIIFg88oqs0RGndw41q6d8o/LLlXENKHeHzpmxngdtt
	TYEyb+KVMsv/jL4rr73cYnaP+zexB39POv9/Juer/cVIwgKvnBWyvTa0
X-Gm-Gg: ASbGncuQlPVn3a4lOfBpzrNA8p1htqec4G8t/i09yZOhcRUZWu17ZH770PD7jhT/X2O
	KDsLAIQl7UA23FTuubdd5CrPDvU/Go2aSW2/S8hqXfLTvxF3Bps3A5JySy/b1EOUv3Wkp00Ep8A
	NgQaEyhdFTdhaaWqAlhXHnL6y7ev9RMZzreb6KD6J2T5RLNlbzcttBF9rbEwqaHnoDS7YoOa2ih
	Htawf3B7cc0tpGqwz7XlmWylUqivF43LE6uk3ZWPW3EzIPvQOozUKzTCRxoJ8NJYTu4OckmuLYF
	OwYqZ8MsIbUnHXJdDQP/hCL9q78JmHGCcfLksBl0QUaQ0ywCaa681eJLH3rq3jH+vc++Z8T/0m0
	1ajev4HmMjwlGx0okVxonFkze4F6jCbjP4J1p5t9xooMEXdSK73uAB1WzVBjOsm4suCDPNaN7y7
	YBB4opVWkRpZEqspAL
X-Google-Smtp-Source: AGHT+IHiwCwLjbXpUrwwrGt3kGlOdWvmVcEPdU+EuNxpT5tIXeT0LZ15xDENATBbl/XUzkCt+aRP4g==
X-Received: by 2002:a17:90b:4f8a:b0:343:78ed:8d19 with SMTP id 98e67ed59e1d1-3472985089cmr19771419a91.7.1764048812581;
        Mon, 24 Nov 2025 21:33:32 -0800 (PST)
Received: from rakuram-MSI ([2409:40f4:2011:4e2a:d22e:5b35:593c:bc8b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7c3ed891ff9sm16836318b3a.30.2025.11.24.21.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 21:33:32 -0800 (PST)
From: Rakuram Eswaran <rakuram.e96@gmail.com>
To: socketcan@hartkopp.net
Cc: linux-can@vger.kernel.org,
	mailhol@kernel.org,
	rakuram.e96@gmail.com
Subject: Re: [canxl v6 05/17] can: netlink: add initial CAN XL support
Date: Tue, 25 Nov 2025 11:03:26 +0530
Message-ID: <20251125053326.6443-1-rakuram.e96@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: feca32b7-9067-4877-ad64-5d4771ca0149@hartkopp.net
References: <feca32b7-9067-4877-ad64-5d4771ca0149@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 24 Nov 2025 at 00:28, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
>
> Hello Rakuram,
>
> some hints how to create a test setup for the CAN XL patches:
>
> You need to build your own CAN XL enabled "ip" tool from the iproute2
> package. This new code can be found in Vincents iproute2-next tree:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/mailhol/iproute2-next.git/
>
> You need to check out the canxl-netlink branch there:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/mailhol/iproute2-next.git/log/?h=canxl-netlink
>
> Once you've built that branch
>
> ./ip link set can0 type can help
>
> shows the new XL specific options.
>
> Of course you need the "can0" interface first:
>
> Load the dummy CAN driver:
>
> # modprobe dummy_can
>
> Enable the debugging to see the output in dmesg :
>
> # echo 'file drivers/net/can/dummy_can.c +p' >
> /sys/kernel/debug/dynamic_debug/control
>
> Then you can e.g. enable the CC/FD/XL mixed-mode without transceiver
> mode switching (TMS):
>
> # ./ip link set can0 type can bitrate 1000000 dbitrate 2000000 fd on
> xbitrate 4000000 xl on
>
> Or e.g. use the CANXL-only mode with TMS enabled:
>
> # ./ip link set can0 type can bitrate 1000000 xbitrate 12308000 xl on
> tms on fd off
>
> After setting the interface to 'up' with
>
> ./ip link set can0 up
>

Thank you for sharing the test steps. I'm going to look into this today.
Going to test using QEMU VM (I hope that works without any issues). 

Best Regards,
Rakuram

