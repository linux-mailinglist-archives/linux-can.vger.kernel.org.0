Return-Path: <linux-can+bounces-5898-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F11CD6589
	for <lists+linux-can@lfdr.de>; Mon, 22 Dec 2025 15:17:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 61B3E3008540
	for <lists+linux-can@lfdr.de>; Mon, 22 Dec 2025 14:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B5132BFC85;
	Mon, 22 Dec 2025 14:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KexmNqb8"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com [209.85.218.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB15329BDAE
	for <linux-can@vger.kernel.org>; Mon, 22 Dec 2025 14:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766413048; cv=none; b=hz1sjVmjpCIKS4amnzWOd6lssbdM+5sYdd6voX+bRAftTUNPQBahe3TmtBbwjV/+8iqp4vTziaiT/g8H+toYkGM3YKe379FcUK5zFKibmFtwtTlGUwvzfLUHzT7dq9r3MFdXi4GuXW27dcCPYuvAXVSEe0lKkD9ZVlqVq9ldXKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766413048; c=relaxed/simple;
	bh=fM6vqSJBpcbmjfTQAFqFrxzYswihGsVNLl25Qi+1jAI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=roWXOo4OG9346VJjZrulma+iLzAZS5G4EPjV77FA3VC/THbxuPYwj00dq7xX2SZFyhAHL3Hr15GEEyqf7Toe0mL+923dY/VXDsJxNCjotZtsmQAgvyKuYnWtB2AAQduzpAk7VkbbZDsIqhLxqGV5bgGr/c4UlYnBOe1lorzmoak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KexmNqb8; arc=none smtp.client-ip=209.85.218.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f67.google.com with SMTP id a640c23a62f3a-b73161849e1so869639866b.2
        for <linux-can@vger.kernel.org>; Mon, 22 Dec 2025 06:17:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766413045; x=1767017845; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fM6vqSJBpcbmjfTQAFqFrxzYswihGsVNLl25Qi+1jAI=;
        b=KexmNqb8hGBBc7XJQiD58uLiW8LnmOtx8xOh1dBCk3Tj4OKGMYLOiJ08mGcehDdEwA
         FMqR9NkZ7VEDPzK9HiI13oY/yU0C6SpNhDtkfgpapaAd3M5V7EAWLTI36eVSQQCH+4KT
         e5VbSLT8iuP7bfCLctVWT2iUeMr6oyAIglGqz/lW5R8KsNQ6/9HzK2uo8BVFpkOC3Q87
         jE0INPdA0TXmmz/+4rKsHpOaKkGUhDQXr/HF7UUbHgWNkQbxjF5RIILgEWa5elNSgGcp
         Ntjus9jbOKjGBFTWaiW3vUsxTRi6zDdwBt75YXzdOfv3pab8CDeKu39Q8wR+U2p4yHn5
         r+wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766413045; x=1767017845;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fM6vqSJBpcbmjfTQAFqFrxzYswihGsVNLl25Qi+1jAI=;
        b=r+GFEg83v/6CY+BZskLm7m/AOD2HWexOrV666ayYS0Qdj767OGLBB9a/ItfZ5WhsEK
         DXnND/5g54qNCVQ2/wpWeBi+qLsUPe9bgGdTF1DuCuAlWax3A1MYR0MCBW0o40qsgW9z
         YrTFwFy5+MCPKb6WZ0+8V0nIGl7IS/mj+6oB5fUgBjGasQNq9YiA+inaMoAQC8P/wimM
         jx47Q1VngH3YrBbOfNaiitnOFy/bI+DxD5WxwtO5qZTNcaRvB6dIDOgVTacB9sh+v+ta
         HVGUWYKpLjulCAKsMapCC8r+FD5KeyLJmbOOqS9g1muKfYXRLuIai6UEViNpkkkz9gW6
         Va2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVAccmW+Ek6pS1GaCytVa8A1Rt5qbDLmG6cAn/psX7SOHjGTpxXWqr8q1zF978MsPiclcSSoFtgKlI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/KMIly7YEeptG6fgXfHJQwI+rfMmSYuF19t414NMV62nYzlwn
	YrAIgzAqnYgEXTShMFZ9cFw175DK/K+/e485yA+0UfxBpXsbkljiypZ8+b//nP1w5dt73oOLtPk
	X91SA0xfIzWDhy7HvE5EMedGFvO8HmW904YrseQQ=
X-Gm-Gg: AY/fxX5m12iefJLKcWIQJOQBTUGohT0j6Ug8Gq5Fe//0X3dtIaiE2n0vhcdaYPGf9Yp
	2sCGsoXEm+VDS1o3WHtyjjCtt0grereJ/qhmvBaLjDZNZzFVkuYzsSCx9xhmElB+6nt3qi5xi5D
	I0RK1P6T9btbRCepJMbpZMfqg5ssbvNx2VX2S1T3+N9fQpQSZi5kkojL18//hILdpbyrWjotRzW
	PcGIERr/B7DYrABhAbaNove6aUB65VLYkBM+vc2BZpdDsCxNcUL3oumdyrqF9xfowJoAh0I361E
	A5pm
X-Google-Smtp-Source: AGHT+IGt3pwiatt0Yk6jGdaNPic8Xi1ZQss5mOsuJ8LTjJWzhmAgDc9m5rtFa1vRZRi1fad8ptew0iSXeiExGnx9xoE=
X-Received: by 2002:a17:907:7ea2:b0:b79:a827:4c4a with SMTP id
 a640c23a62f3a-b8036f1308cmr1137766266b.15.1766413044771; Mon, 22 Dec 2025
 06:17:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Andrea Daoud <andreadaoud6@gmail.com>
Date: Mon, 22 Dec 2025 22:17:13 +0800
X-Gm-Features: AQt7F2pTgp2gxOhmcyNNHFZAfa_e2lJfepC7YpTFdJD2-jQlo84eDj_laQbHSjg
Message-ID: <CAOprWotBRv_cvD3GCSe7N2tiLooZBoDisSwbu+VBAmt_2izvwQ@mail.gmail.com>
Subject: ctucanfd: possible coding error in ctucan_set_secondary_sample_point
 causing SSP not enabled
To: Pavel Pisa <pisa@cmp.felk.cvut.cz>, Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc: Wolfgang Grandegger <wg@grandegger.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>, netdev@vger.kernel.org, 
	Ondrej Ille <ondrej.ille@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi,

In ctucan_set_secondary_sample_point(), there's a line which runs when
data bitrate is >1Mbps:

ssp_cfg |= FIELD_PREP(REG_TRV_DELAY_SSP_SRC, 0x1);

In the datasheet [1] of ctucanfd, we can see the meaning of SSP_SRC:

SSP_SRC: Source of Secondary sampling point.
0b00 - SSP_SRC_MEAS_N_OFFSET - SSP position = TRV_DELAY (Measured
Transmitter delay) + SSP_OFFSET.
0b01 - SSP_SRC_NO_SSP - SSP is not used. Transmitter uses regular
Sampling Point during data bit rate.
0b10 - SSP_SRC_OFFSET - SSP position = SSP_OFFSET. Measured
Transmitter delay value is ignored.

Therefore, setting it to 1 disables SSP (NO_SSP). We should probably
set it to 0 (MEAS_N_OFFSET).

Is this correct? Would like to hear some inputs.

Regards,

Andrea

[1]: https://canbus.pages.fel.cvut.cz/ctucanfd_ip_core/doc/Datasheet.pdf

