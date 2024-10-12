Return-Path: <linux-can+bounces-1640-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8344299B719
	for <lists+linux-can@lfdr.de>; Sat, 12 Oct 2024 22:55:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A89031C20C8F
	for <lists+linux-can@lfdr.de>; Sat, 12 Oct 2024 20:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE39146590;
	Sat, 12 Oct 2024 20:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mq/ARfWX"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFF913B7A3
	for <linux-can@vger.kernel.org>; Sat, 12 Oct 2024 20:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728766517; cv=none; b=tbOVe/bQbbWgU7Ah1Uf7RUM7xT7fUmbjTlkO30cAf5WpHR6fHuyGyGiBfyJFeYEPY0bZG1yYpu2Rz6UQgW2NEZpdYu2W9Iu0IzMS7+0H4h36C5ThbUqIkFaFxx1w9UgEKLn+W4qLOSY2ZKgP+/UXu0no0C2PMpYf1tfOjyXAZPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728766517; c=relaxed/simple;
	bh=uJ4G7qJ6RqF7GwzpPOknQJ1zl0q5+A5aAWNE57llAUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XOTJNTWxTKz47XAI9v8Bf+Y5FNbh3GSfzB600yimVJobeGaJE+hPLZdoJc0/BGr9SAYEvmTfqnd1EIdHTAGryhasnBJUUzFnSbs0vD0XQHrW97BRybgcYB5BTeaVQFmHAlCyGAEKaqjD0trg1WcHSNKMVMkWomdg0QuMHTQXvZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mq/ARfWX; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a99ffeea60bso15319666b.3
        for <linux-can@vger.kernel.org>; Sat, 12 Oct 2024 13:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728766513; x=1729371313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uJ4G7qJ6RqF7GwzpPOknQJ1zl0q5+A5aAWNE57llAUk=;
        b=Mq/ARfWXOC4rcUpmBIy+7PD5M4uXhv0QH+cWBqBp+RzotIdGPiE+MlWUjRDAg9TSU2
         L7MWA/NKBGz/C/6vWRpBBv3Vs0dcqw8l1hVq65SP099i6ruo6AzRYKkfSnpA9/u1m3wg
         58NfOba7KDNItWGkITWb9f+BlIeR7eatBdOqHa+gCwxNFae2ugcrh2/ckg+6J3/zK8Hl
         xNRnDG+HsM1BiG4FJ8ouk5pP17Lp/VU3ytwPIc1SPULaEi+NJ9dllgeGBqi5wcPYhKfD
         K3sVhm0r8fzv/tLB768fwE3T6yHJ8icXxGNwfMlLgxP4qDkdYVU60Z7Q654BocjmG2ow
         sXew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728766513; x=1729371313;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uJ4G7qJ6RqF7GwzpPOknQJ1zl0q5+A5aAWNE57llAUk=;
        b=M0jAQn2bh9zW1VSXHvO7tT4cksxZC7rh4K1+BdsMbH+ZwQxL7j9poNST2M8GomZB/v
         ucPF/tGtrXV03t9SFv+/6IQ2rA0qwgHI9T8MYVuqJrqHrbVG0xl8RMwUVZIl4Rtj24Tq
         Nls/VHFNlIQsgGjAv3+TsS+5uixSGZsaJXZUhzejJ3QUgHdyb1BUWLyloYhXPj+nSlYD
         nbo4W+mAeX/Yhz0R6C50Dkwieqp3+98idxmucnf30sfhrs+vxwujpZ3p1/Ck4dIonQ9e
         03Y/70jrymjuHOUIZzwbvYK7zmQFOIPn9jYLRM/qBESL3lizXSWlxs2bXPtDY/Z6N4qu
         BskA==
X-Forwarded-Encrypted: i=1; AJvYcCWmJEyCrLObEYs/AQPzZNgDLeEd4Rhr7QSFXIztO5NVnZqFcbdfpohl6d16ngHh0b8kFJohSaWIJiI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq4Jd3HLAh44wKWXN2NXS98CS7/Bcbel6fukFelQQ5WFEG1njj
	4lgvOVwf8PcaGkCTBpdYC6VCe6Zz9CEui7cQWRbeY2sHULVVU+yY
X-Google-Smtp-Source: AGHT+IGiZPGwV9SA1Wd7eYMkQkk6W16QdpCfckpwu1ZKOSRaMRe69TWo8M5HH3ldVPTCO31COi8tgQ==
X-Received: by 2002:a17:907:360c:b0:a99:499f:4cb7 with SMTP id a640c23a62f3a-a99b940530bmr596100166b.23.1728766512705;
        Sat, 12 Oct 2024 13:55:12 -0700 (PDT)
Received: from localhost.localdomain (ip-037-201-007-048.um10.pools.vodafone-ip.de. [37.201.7.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a7ede92bsm361552066b.28.2024.10.12.13.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Oct 2024 13:55:12 -0700 (PDT)
From: Alexander Kozhinov <ak.alexander.kozhinov@gmail.com>
To: mailhol.vincent@wanadoo.fr
Cc: ak.alexander.kozhinov@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	max@schneidersoft.net,
	mkl@pengutronix.de,
	pabeni@redhat.com
Subject: Subject: Reviewer Reply
Date: Sat, 12 Oct 2024 22:54:33 +0200
Message-ID: <20241012205433.7268-1-ak.alexander.kozhinov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAMZ6Rq+rAdyYKOpna1T7dhEV69cuTNFK+gHy4oCfSf0+AmGtyg@mail.gmail.com>
References: <CAMZ6Rq+rAdyYKOpna1T7dhEV69cuTNFK+gHy4oCfSf0+AmGtyg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Hi Alexander,
>
> Thank you for this v4, the patch is overall good (there are two minor
> comments left to address). With this, I think you are done with your
> on boarding on understanding the patch submission process. Congrats
> for your first patch on the mailing list!

Hi Vincent thank you also from my side for careful and paitient guiding me through
all the steps and specialities of linux kernel mailing lists. I've learned a lot about them.
I will address requested changes and come with v5.

Best Regards,
Alexander Kozhinov

