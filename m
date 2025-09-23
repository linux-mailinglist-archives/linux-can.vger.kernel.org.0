Return-Path: <linux-can+bounces-4855-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20476B947C9
	for <lists+linux-can@lfdr.de>; Tue, 23 Sep 2025 08:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5FE644440D
	for <lists+linux-can@lfdr.de>; Tue, 23 Sep 2025 06:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 227E030DEA6;
	Tue, 23 Sep 2025 06:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JGj3W5dG"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED026305977;
	Tue, 23 Sep 2025 06:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758607372; cv=none; b=jzw/ZJyyo6/I72TZ3ZCFC6aBmFskYAzZ3wreO/7k7u41ZXHcgFCcqAOJnKU8xDvbHeo61f5ooBYo0z1J6xDhfPfH7G9BE3HD4HrK/EM/I2fzAvt2PeT0r7sZfWdML4LAnUV7/g4I1EfAcAKN9ZlTR3v04H7RejWLsjRCqFwNvl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758607372; c=relaxed/simple;
	bh=YzCiBxoRGHXX9LPMyw+z17ZIgR5e3rx7a3XAk+PEvd4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kyui040Ct+xfBzb7UG+mLYkZig6bfDz97GWOfCoGvIT04kGZx9PtV2wsNYHzND5IEYCIeZqnslpxEX/FNYOAaHL5LWeyy3i/3mNFkCrwF06nCSzZ9NaD4kgaKfxnFzSTUVU2UK5P4m32xiBRxo179cNLBkIorFUfsNZo0A3gO8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JGj3W5dG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93194C4CEF5;
	Tue, 23 Sep 2025 06:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758607371;
	bh=YzCiBxoRGHXX9LPMyw+z17ZIgR5e3rx7a3XAk+PEvd4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JGj3W5dGpwJQukG05fDkas9WjP+Atm19RjYoBUXnhIx7VzJI5mHluJd0UMb/6mzaP
	 J2g7RIq36sSeNAI64mmz7rCOtoNl9lHUFTYAr2p3vDF2iT51x5OFAemrkGR2UhgXcf
	 Hs5EozV/yb+zyTKtDSM2bFIiEMxo+/Zm5KHN7hG28+kEYLaYvqEvGN7Hu3uBybWDI8
	 i7dPiFKAQRiIfqOrNVKZb5kgqy9b6qDkwzz2Gx1/Uhyn/f7lsRSSftOLC9t2dmpWZq
	 rrZWx7EVk8kjErVbi5SLkp2CWTpBNki0T+8xHFX3HeUWtkmMhHhTexs7rFvRH7ZKe+
	 1XJ4AUbnBFacg==
Message-ID: <13f98eed-b535-4360-a545-0a11dbc8aa12@kernel.org>
Date: Tue, 23 Sep 2025 15:02:49 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/20] can: netlink: preparation before introduction of
 CAN XL step 3/3
To: Marc Kleine-Budde <mkl@pengutronix.de>,
 Oliver Hartkopp <socketcan@hartkopp.net>
Cc: =?UTF-8?Q?St=C3=A9phane_Grosjean?= <stephane.grosjean@hms-networks.com>,
 Robert Nawrath <mbro1689@gmail.com>, Minh Le <minh.le.aj@renesas.com>,
 Duy Nguyen <duy.nguyen.rh@renesas.com>, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250923-canxl-netlink-prep-v3-0-87a7684333f3@kernel.org>
Content-Language: en-US
From: Vincent Mailhol <mailhol@kernel.org>
Autocrypt: addr=mailhol@kernel.org; keydata=
 xjMEZluomRYJKwYBBAHaRw8BAQdAf+/PnQvy9LCWNSJLbhc+AOUsR2cNVonvxhDk/KcW7FvN
 JFZpbmNlbnQgTWFpbGhvbCA8bWFpbGhvbEBrZXJuZWwub3JnPsKZBBMWCgBBFiEE7Y9wBXTm
 fyDldOjiq1/riG27mcIFAmdfB/kCGwMFCQp/CJcFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcC
 F4AACgkQq1/riG27mcKBHgEAygbvORJOfMHGlq5lQhZkDnaUXbpZhxirxkAHwTypHr4A/joI
 2wLjgTCm5I2Z3zB8hqJu+OeFPXZFWGTuk0e2wT4JzjgEZx4y8xIKKwYBBAGXVQEFAQEHQJrb
 YZzu0JG5w8gxE6EtQe6LmxKMqP6EyR33sA+BR9pLAwEIB8J+BBgWCgAmFiEE7Y9wBXTmfyDl
 dOjiq1/riG27mcIFAmceMvMCGwwFCQPCZwAACgkQq1/riG27mcJU7QEA+LmpFhfQ1aij/L8V
 zsZwr/S44HCzcz5+jkxnVVQ5LZ4BANOCpYEY+CYrld5XZvM8h2EntNnzxHHuhjfDOQ3MAkEK
In-Reply-To: <20250923-canxl-netlink-prep-v3-0-87a7684333f3@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/09/2025 at 14:39, Vincent Mailhol wrote:

(...)

> base-commit: 9b277fca90c39c8b749e659bf5c23e924c46c93b
> change-id: 20250831-canxl-netlink-prep-9dbf8498fd9d
> prerequisite-change-id: 20250915-can-fix-mtu-050a94b563a0:v2
> prerequisite-patch-id: 03836ed1e416f9ea221e149842cc075ac174dd3a
> prerequisite-patch-id: dac8f6d20f91cf996553905f08c629ca3e61d86f
> prerequisite-patch-id: 063df0e5636fc4f948bbc39da42cb1b164717c8a
> prerequisite-patch-id: ad5cb0d2a242d1dbe67634f580778e5f24068f25
> prerequisite-patch-id: 9cf567f2b7375cec16979c0a799e14cbb7ad01a0
> prerequisite-patch-id: 778252fc63c5e3890179974ff65136e5a738a5ec
> prerequisite-patch-id: 3cf20ca8cea2ee5a0408e15e87b5c204046304d0
> prerequisite-patch-id: 3afb504b96e75a139657e1b978837f82e471a5d1
> prerequisite-patch-id: fd91bfa798c044583122d74acc4ec323cbcffe09
> prerequisite-patch-id: 1a5955242c0ee1b117038a1afe92947d17c6acd3
> prerequisite-patch-id: 8b239212218db67a7a608f6787837e16c9d186be
> prerequisite-patch-id: 438c8ee4453f85a07d469a27227f23241204f51e
> prerequisite-patch-id: 3484cb17c09383a4a01efd3214ce5e851c08b2d4
> prerequisite-patch-id: bdf470a2cd0a07429e0bdaad1dcbae366d375a96
> prerequisite-patch-id: a4133dfc6f0ac7306d496f20bf4d217d92427682
> prerequisite-patch-id: e6ff959f89d391431e2603df9add35bb8c1445b6
> prerequisite-patch-id: 06ef619f4682dc11f972b9e08983cf57565a57b4
> prerequisite-patch-id: cd0fbd4fd409a0b1267e514c86000d3c60b38574
> prerequisite-patch-id: 7f4dd5a40cbe1332333a213ac6f303d0554c2465
> prerequisite-patch-id: 584c079fc06a3a4f0b21f7b56de953ad9c67aff7
> prerequisite-patch-id: 19dc4584f58625c416a0d05e0c7b274e6d76ede0
> prerequisite-patch-id: 917e153fa32a5a3e7f796a1e5e1ed54ddaffd383
> prerequisite-patch-id: d5e8a1cf5d8ce8e553d02a64ee324909d7b74526
> prerequisite-patch-id: 4539e3432ffbacc270660aeefa2b227d93d40dc2
> prerequisite-patch-id: 869f0164b99a35b0226152810d228b96e12eb161
> prerequisite-patch-id: 8e078129111c08e2641597a1f949b4dfd36f685d
> prerequisite-patch-id: 53e2273be34a28885a28ff549ca07d8670e2f7db
> prerequisite-patch-id: e0f183179eb5704a2c8a24e85db6f2af6622bd09
> prerequisite-patch-id: 97358a34b86cf3d8fa7b0e4fab3162cb1bb12fd9
> prerequisite-patch-id: 1c2e911a57eec3f60f8f30a01d69611e02a107cb
> prerequisite-patch-id: 7d760019e7cd739b9885c5c4953bca7f6d05839e
> prerequisite-patch-id: 04be2d889fa466f414b3ab098a29a8c11c9ffea4
> prerequisite-patch-id: 03ae9e4833add51f0dcda8f0aed434db21596c0e
> prerequisite-patch-id: bb42f43d5e677ae526a09d224a805b558993d5a4
> prerequisite-patch-id: d80b4f58c33850c76ad7a9fd57037f79899976c2
> prerequisite-patch-id: a9e8365b9183382cfff4ba7e873d3c84b6f3002d
> prerequisite-patch-id: 03b962eca8161f9585f15d09b02baabb156a0a82
> prerequisite-patch-id: 823eee7fb38bc0b8c3ce6b7785ecff3351c02462
> prerequisite-patch-id: 07fbf3dd9583e9b67ed2c6ca6350a916fc509fb1
> prerequisite-patch-id: f9d3aa0f7c8a00c544dc501300ea56889e3fe336
> prerequisite-patch-id: 4e3135a0796429b863e96c026e57fa0745879a62
> prerequisite-patch-id: 06eba32c522fbcf1b4b6568d7ad65fb6cfbbd96f
> prerequisite-patch-id: cecf14467f62de74c2b7c8a974607fd929d4ba6d
> prerequisite-patch-id: 6d08ce52c12c70d3f5410c2cc211a3adc5df68ea
> prerequisite-patch-id: 64a707942d6235ad1bbc1d8f4f7309159d49efe2
> prerequisite-patch-id: d0e1f11d79b80b4fcb2d1e4ac9024cd55ca67637
> prerequisite-patch-id: 2e8bb13a23560d1c649ae8cff764c8181d6c585b
> prerequisite-patch-id: 27551cf469fae44fd3c4e533124a35955ec16f48
> prerequisite-patch-id: 2c53c35fbf777eefa9d866fab67512cd5eaf5e37
> prerequisite-patch-id: 78dadcf62f46dd0b68d12e4a548aca5b31cce6cd
> prerequisite-patch-id: 1ebb626d58e8c6e92279409a58f1000a24e8187b
> prerequisite-patch-id: 450a555e6cfd996bc3044c565f614eb8c5eb80c4
> prerequisite-patch-id: c2131d560c6d2f78a74f08d876188308faf146bf
> prerequisite-patch-id: 4d2e60706d4c3d49bb04e71081440203b64e52b0
> prerequisite-patch-id: c29c844583533905f649795a14e631816b6649f8
> prerequisite-patch-id: 9fbe119faee0052c248c1fa449b061a4ff818e8a
> prerequisite-patch-id: 276126fbdb98b02fec6afc34f72bdd2acd68ad7d
> prerequisite-patch-id: 164652e88dcae476396fae958a822c4f3a5613b6
> prerequisite-patch-id: 87d94bd2e2c752c26c6b11c61d64cea737e08b38
> prerequisite-patch-id: e19b5076fa211ad2fa950a21088857051216ce32
> prerequisite-patch-id: 671d3d8e4b272b5564280db66c6af33e38b249bf
> prerequisite-patch-id: 0227d6030cc3dd66ef2ebf940c1f0f747e65dd9d
> prerequisite-patch-id: 732d36e42c161025d4de1592decfdfeace69a65b
> prerequisite-patch-id: 1d49368163386d507fa5dc3e89a272c3118824ec
> prerequisite-patch-id: 491bb6e62499c3dd0ed4248c62bad3e8979a4843
> prerequisite-patch-id: afe1b7d2c900dfbbb1149e5b70b24d4e1981de89
> prerequisite-patch-id: cdfa0d42a305a2f27c7bcb07e988b4282de5b3f8
> prerequisite-patch-id: a78db1ee67f5c52edbb67e219116e584c71e8dea
> prerequisite-patch-id: 69bf16db7f0c34a472486b8146c897c9d37e2354
> prerequisite-patch-id: 892132cdaa7b33213bdb124aa4c0ce7226f9c933
> prerequisite-patch-id: 031f4e68e86b64ac198b433143b34ed8e1b36a2e
> prerequisite-patch-id: 387f5a52c0e04649d0784d1ab778c4636136218f
> prerequisite-patch-id: 38cb8b3495b7c96aee4db4105cb60ed69807283a
> prerequisite-patch-id: 5ddd72a4f9704fbcec9a6df3072f388e8ec19add
> prerequisite-patch-id: 6d1b3ba26a954f155a7f867b3d74a6d25947d4a3
> prerequisite-patch-id: 4da977ad4b3c2bd1155af70fd3318120ffc33e7c
> prerequisite-patch-id: 7e7e22dd3448ca9085ad81c580dbec0d8b1aa496
> prerequisite-patch-id: 82f247ef1284e4ebc03facaffe454e5400895d58
> prerequisite-patch-id: 321d5ba812a5d2e2821b9afb96a5b3afc6b35082
> prerequisite-patch-id: ae61c8645b047697e0166d2f73e9983397c28e5b
> prerequisite-patch-id: b14bcfa1856f18fb6b23002b8b43bb31268dba79
> prerequisite-patch-id: df590935630616e0775959e50bab45ac8176a51a
> prerequisite-patch-id: 5ee2c6363a79880b1b474741c736a657b64c3e30
> prerequisite-patch-id: dd0c62481a5f5a3ef73cf844f0cbca0947d43026
> prerequisite-patch-id: 9acbb3ec5c33c6d3dd9ec8bce148966d1c4c07f8
> prerequisite-patch-id: cf96dcca8ad704583c2b00205197a5096799f809
> prerequisite-patch-id: 513d44845743120511e5700208fcd61e8b0a9c4b
> prerequisite-patch-id: 598861ab70a52a5217d1ad4450837b528fb05f16
> prerequisite-patch-id: 581237d23101184c4923f25081913c2e3f52a92f
> prerequisite-patch-id: 68fa6bb52f4944af2b7cbdf106f0365108b9d019
> prerequisite-patch-id: 14ac750f0743ca403de15c6fe5647d716b199f43
> prerequisite-patch-id: 0d0c827dc03bbfd4e5032c8c3b3fd665243753be
> prerequisite-patch-id: fa6e47e8d2aecb5550165f44fb8aefc3053a2240
> prerequisite-patch-id: 764a62804dc0bcac320ad05e466ec4b07113a9e4
> prerequisite-patch-id: 6ef91f0837fbf1e87004c6970d2aba1c7a7bbd22
> prerequisite-patch-id: ba0d12a6b956ab3b9de9967c501fde3b572e52c1
> prerequisite-patch-id: 4b117cfaddc81bd773c90205936d9cd095fc61dd
> prerequisite-patch-id: b513ceff1c32aae46ee65d31306b700620d52812
> prerequisite-patch-id: 0c7cbd97f62e11024e6c2d1b42cd84abc1c56bf9
> prerequisite-patch-id: a12fcf7da8dd5c188004c40cf9e8bd7f88766409
> prerequisite-patch-id: 7279cb66eb0adc348e6cf33f62b60ded01673241
> prerequisite-patch-id: 35532d41a6f25cbc81e08b81351a064e109a7929
> prerequisite-patch-id: 13003d4ff68f7593d9f09b1841be4eb5d9213c3c
> prerequisite-patch-id: 708d680203aefb63e489982a1f34e30de14abaf6
> prerequisite-patch-id: f1848f4fe69814ac15707d7c6caf8e447b50e512
> prerequisite-patch-id: 786d5d3bb21ece31dbe800830bfe18509ab218e5
> prerequisite-patch-id: 99956115402d9ae9552da1d5350ac05e850c8cf2
> prerequisite-patch-id: 0c31fe1bedc4f4e130f14ff5fef47d3a786bafaf
> prerequisite-patch-id: 1594888c870e9108f969aa068dc53a922d9abb9e
> prerequisite-patch-id: 90521c92a58cb5662a18a126bd80df09811708fd
> prerequisite-patch-id: 1aab04b4aa912c8194eb0e5ac1955cce9c265b23
> prerequisite-patch-id: cb61e2d87ac480b42dde616d67f4789ef14e2563
> prerequisite-patch-id: 9a8954c818f85b78adf346fa1ae5a96998526d12
> prerequisite-patch-id: ee631478d799fa0d5c861550c849e3058ff72d08
> prerequisite-patch-id: 8109f84818154c8b9ba5f19db5e91ef8e26224a9
> prerequisite-patch-id: d4080565fd7f54b25c17df284b6749b92a36787e
> prerequisite-patch-id: 64b7803b5453bdd2ada5f2918901ad092e4ea1cf
> prerequisite-patch-id: 6aecc3f1db1cd342e3b204310464179ca66b52ba
> prerequisite-patch-id: 10e3a79796f2966733349c4cfcc1a61a49bc20af
> prerequisite-patch-id: 5ddc3c20a99f60bddb62d58eb192facf0eb25b75

So, when sending, I was based on Linus tree instead of net-next. I guess this is
why all those prerequisite-patch-id are showing up...

I got no warnings when doing a:

  b4 prep --check-deps

so I assumed that everything was OK. I will resend, sorry for the noise.


Yours sincerely,
Vincent Mailhol


