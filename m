Return-Path: <linux-can+bounces-4834-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA78EB946ED
	for <lists+linux-can@lfdr.de>; Tue, 23 Sep 2025 07:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A2653B7A85
	for <lists+linux-can@lfdr.de>; Tue, 23 Sep 2025 05:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8F26264602;
	Tue, 23 Sep 2025 05:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fGFlktAg"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0156224F6;
	Tue, 23 Sep 2025 05:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758606047; cv=none; b=dO1zV54j/0Tdb+5TMYZis8jNeCbcR7uLIvjx5saIY5rjpMZdu8X6GY1WtsdkZKHiRZdQeZoVh11950IA7eFUwYtJH4PF+MuKlr9ivNiUMt8GCZmGHyJgZhDHTiEwktWRsSV7a1rEODDzovGlWVnBdWflU+ofVH1AgW+xFX7k0mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758606047; c=relaxed/simple;
	bh=mlOGLov4dSI/kowF2fEvKGWEfGDpF57d/MqCJp8Fk7g=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=KCX/C5Yu6DrIko6HFK7Kp6fEDE9fSyk5Iq/RHDTYRgACy//ROAKXP5+/Dfo4hkt6U0vzR0on7UgTp1UHT9K4SxjpB4aQNjLXDf4o5V8KZRO51SjCCcEBQ0mU18Pnr6iIoORtNeL9PvEpf26vRzeAqmaJ/ZfO2GxtCihLxZKSnSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fGFlktAg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CED62C4CEF5;
	Tue, 23 Sep 2025 05:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758606047;
	bh=mlOGLov4dSI/kowF2fEvKGWEfGDpF57d/MqCJp8Fk7g=;
	h=From:Subject:Date:To:Cc:From;
	b=fGFlktAg/BkRUALcJArxz26NycIhtIc1kW2M4h37k3MljxM4JeFLIMpTj1th6Pa5V
	 3YciuHYxU7xGk4az00liBMbZIIgnlF11O96vREaGQQ7TKVfypjQxx3UKcvW1+70JSm
	 AI9H4yt2y2u5zN15AWFTo7EWDamFUAr3lNdtaqtgPLEK/HSvpOs6LJGoh5qODtc8jl
	 aRh5zWXjBwG6gm7ESJIvCU4gB82JLmfMrRdPKJBngXAPpyRXSM+wlW9xfW4a6c2JBV
	 gzSkVGtQ9BHawYygBwcKe+sr57W3P5OHtiCxuhvoTp4KAvG1NLdVWjrZNAOkD96PXB
	 mM7bm6jxPqQYA==
From: Vincent Mailhol <mailhol@kernel.org>
Subject: [PATCH v3 00/20] can: netlink: preparation before introduction of
 CAN XL step 3/3
Date: Tue, 23 Sep 2025 14:39:35 +0900
Message-Id: <20250923-canxl-netlink-prep-v3-0-87a7684333f3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAJky0mgC/23QwW6DMAwG4FdBOc+bk0BLOO09ph0CMW1UCF2SI
 qaKd58Lh21Sj78lf3/iu0gUPSXRFHcRafbJT4GDfilEd7bhROAdZ6FQVVhrCZ0NywCB8uDDBa6
 RrmBc29elqXtnnOBFHvZ+2dCPzz1H+rqxnfehaG0i6KZx9Lkp2GJvyW+j9UH8LW6KrdbI6lELj
 MKYb4AVWlO21UFbbGYlHh1nn/IUv7d/zHIr2XdRP3vyLAHBYNm6A+pj58z7hWKg4XWKp81j9te
 Q+NRQbPRS1a7kyxyV/Ges6/oDZu+VhV0BAAA=
X-Change-ID: 20250831-canxl-netlink-prep-9dbf8498fd9d
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Vincent Mailhol <mailhol@kernel.org>, 
 =?utf-8?q?St=C3=A9phane_Grosjean?= <stephane.grosjean@hms-networks.com>, 
 Robert Nawrath <mbro1689@gmail.com>, Minh Le <minh.le.aj@renesas.com>, 
 Duy Nguyen <duy.nguyen.rh@renesas.com>, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=14847; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=mlOGLov4dSI/kowF2fEvKGWEfGDpF57d/MqCJp8Fk7g=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDBmXjJbHlzWF9PgJGa6Lnuh8qIZxc+/3G71qLyWS3+5Mz
 Xp/cr9gRykLgxgXg6yYIsuyck5uhY5C77BDfy1h5rAygQxh4OIUgIk83cXwz+QRT6mL5nXb37vY
 nHPTt7k4xivrfCzivCqtvlfvqhjDUkaGZz+0776X+vI5JevUsdZ732b1KFsXh2wJOD2js3eTiwM
 jNwA=
X-Developer-Key: i=mailhol@kernel.org; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2

In November last year, I sent an RFC to introduce CAN XL [1]. That
RFC, despite positive feedback, was put on hold due to some unanswered
question concerning the PWM encoding [2].

While stuck, some small preparation work was done in parallel in [3]
by refactoring the struct can_priv and doing some trivial clean-up and
renaming. Initially, [3] received zero feedback but was eventually
merged after splitting it in smaller parts and resending it.

Finally, in July this year, we clarified the remaining mysteries about
PWM calculation, thus unlocking the series. Summer being a bit busy
because of some personal matters brings us to now.

After doing all the refactoring and adding all the CAN XL features,
the final result is more than 30 patches, definitively too much for a
single series. So I am splitting the remaining changes three:

  - can: rework the CAN MTU logic [4]
  - can: netlink: preparation before introduction of CAN XL (this series)
  - CAN XL (will come right after the two preparation series get merged)

And thus, this series continues and finishes the preparation work done
in [3] and [4]. It contains all the refactoring needed to smoothly
introduce CAN XL. The goal is to:

  - split the functions in smaller pieces: CAN XL will introduce a
    fair amount of code. And some functions which are already fairly
    long (86 lines for can_validate(), 215 lines for can_changelink())
    would grow to disproportionate sizes if the CAN XL logic were to
    be inlined in those functions.

  - repurpose the existing code to handle both CAN FD and CAN XL: a
    huge part of CAN XL simply reuses the CAN FD logic. All the
    existing CAN FD logic is made more generic to handle both CAN FD
    and XL.

In more details:

  - Patch #1 moves struct data_bittiming_params from dev.h to
    bittiming.h and patch #2 makes can_get_relative_tdco() FD agnostic
    before also moving it to bittiming.h.

  - Patch #3 adds some comments to netlink.h tagging which IFLA
    symbols are FD specific.

  - Patches #4 to #6 are refactoring can_validate() and
    can_validate_bittiming().

  - Patches #7 to #11 are refactoring can_changelink() and
    can_tdc_changelink().

  - Patches #12 and #13 are refactoring can_get_size() and
    can_tdc_get_size().

  - Patches #14 to #17 are refactoring can_fill_info() and
    can_tdc_fill_info().

  - Patch #18 makes can_calc_tdco() FD agnostic.

  - Patch #19 adds can_get_ctrlmode_str() which converts control mode
    flags into strings. This is done in preparation of patch #20.

  - Patch #20 is the final patch and improves the user experience by
    providing detailed error messages whenever invalid parameters are
    provided. All those error messages came into handy when debugging
    the upcoming CAN XL patches.

Aside from the last patch, the other changes do not impact any of the
existing functionalities.

The follow up series which introduces CAN XL is nearly completed but
will be sent only once this one is approved: one thing at a time, I do
not want to overwhelm people (including myself).

[1] https://lore.kernel.org/linux-can/20241110155902.72807-16-mailhol.vincent@wanadoo.fr/
[2] https://lore.kernel.org/linux-can/c4771c16-c578-4a6d-baee-918fe276dbe9@wanadoo.fr/
[3] https://lore.kernel.org/linux-can/20241110155902.72807-16-mailhol.vincent@wanadoo.fr/
[4] https://lore.kernel.org/linux-can/20250923-can-fix-mtu-v2-0-984f9868db69@kernel.org/

To: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Vincent Mailhol <mailhol@kernel.org>
Cc: Stéphane Grosjean <stephane.grosjean@hms-networks.com>
Cc: Robert Nawrath <mbro1689@gmail.com>
Cc: Minh Le <minh.le.aj@renesas.com>
Cc: Duy Nguyen <duy.nguyen.rh@renesas.com>
Cc: linux-can@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
---
Changes in v3:

  - Rebase on top of the "can: rework the CAN MTU logic" series.

  - Add a static_assert() in can_validate_databittiming() to prove
    that the nla attributes were already correctly aligned.

  - Replace the ! operator by ~ to fix a bug in patch #7:
    "can: netlink: refactor CAN_CTRLMODE_TDC_{AUTO,MANUAL} flag reset logic".

Link to v2: https://lore.kernel.org/r/20250910-canxl-netlink-prep-v2-0-f128d4083721@kernel.org

Changes in v2:

  - Move can_validate()'s comment block to can_validate_databittiming().
    Consequently,

      [PATCH 07/21] can: netlink: remove comment in can_validate()

    from v1 is removed.

  - Change any occurrences of WARN_ON(1) into return -EOPNOTSUPP to
    suppress the three gcc warnings which were reported by the kernel
    test robot:
    Link: https://lore.kernel.org/linux-can/202509050259.NjPdQyAD-lkp@intel.com/
    Link: https://lore.kernel.org/linux-can/202509050404.ZLQknagH-lkp@intel.com/
    Link: https://lore.kernel.org/linux-can/202509050541.1FKRbqOi-lkp@intel.com/

  - Small rewrite of patch #12 "can: netlink: make can_tdc_get_size()
    FD agnostic" description to add more details.

Link to v1: https://lore.kernel.org/r/20250903-canxl-netlink-prep-v1-0-904bd6037cd9@kernel.org

---
Vincent Mailhol (20):
      can: dev: move struct data_bittiming_params to linux/can/bittiming.h
      can: dev: make can_get_relative_tdco() FD agnostic and move it to bittiming.h
      can: netlink: document which symbols are FD specific
      can: netlink: refactor can_validate_bittiming()
      can: netlink: add can_validate_tdc()
      can: netlink: add can_validate_databittiming()
      can: netlink: refactor CAN_CTRLMODE_TDC_{AUTO,MANUAL} flag reset logic
      can: netlink: remove useless check in can_tdc_changelink()
      can: netlink: make can_tdc_changelink() FD agnostic
      can: netlink: add can_dtb_changelink()
      can: netlink: add can_ctrlmode_changelink()
      can: netlink: make can_tdc_get_size() FD agnostic
      can: netlink: add can_data_bittiming_get_size()
      can: netlink: add can_bittiming_fill_info()
      can: netlink: add can_bittiming_const_fill_info()
      can: netlink: add can_bitrate_const_fill_info()
      can: netlink: make can_tdc_fill_info() FD agnostic
      can: calc_bittiming: make can_calc_tdco() FD agnostic
      can: dev: add can_get_ctrlmode_str()
      can: netlink: add userland error messages

 drivers/net/can/dev/calc_bittiming.c |  10 +-
 drivers/net/can/dev/dev.c            |  33 ++
 drivers/net/can/dev/netlink.c        | 627 ++++++++++++++++++++++-------------
 include/linux/can/bittiming.h        |  48 ++-
 include/linux/can/dev.h              |  42 +--
 include/uapi/linux/can/netlink.h     |  14 +-
 6 files changed, 485 insertions(+), 289 deletions(-)
---
base-commit: 9b277fca90c39c8b749e659bf5c23e924c46c93b
change-id: 20250831-canxl-netlink-prep-9dbf8498fd9d
prerequisite-change-id: 20250915-can-fix-mtu-050a94b563a0:v2
prerequisite-patch-id: 03836ed1e416f9ea221e149842cc075ac174dd3a
prerequisite-patch-id: dac8f6d20f91cf996553905f08c629ca3e61d86f
prerequisite-patch-id: 063df0e5636fc4f948bbc39da42cb1b164717c8a
prerequisite-patch-id: ad5cb0d2a242d1dbe67634f580778e5f24068f25
prerequisite-patch-id: 9cf567f2b7375cec16979c0a799e14cbb7ad01a0
prerequisite-patch-id: 778252fc63c5e3890179974ff65136e5a738a5ec
prerequisite-patch-id: 3cf20ca8cea2ee5a0408e15e87b5c204046304d0
prerequisite-patch-id: 3afb504b96e75a139657e1b978837f82e471a5d1
prerequisite-patch-id: fd91bfa798c044583122d74acc4ec323cbcffe09
prerequisite-patch-id: 1a5955242c0ee1b117038a1afe92947d17c6acd3
prerequisite-patch-id: 8b239212218db67a7a608f6787837e16c9d186be
prerequisite-patch-id: 438c8ee4453f85a07d469a27227f23241204f51e
prerequisite-patch-id: 3484cb17c09383a4a01efd3214ce5e851c08b2d4
prerequisite-patch-id: bdf470a2cd0a07429e0bdaad1dcbae366d375a96
prerequisite-patch-id: a4133dfc6f0ac7306d496f20bf4d217d92427682
prerequisite-patch-id: e6ff959f89d391431e2603df9add35bb8c1445b6
prerequisite-patch-id: 06ef619f4682dc11f972b9e08983cf57565a57b4
prerequisite-patch-id: cd0fbd4fd409a0b1267e514c86000d3c60b38574
prerequisite-patch-id: 7f4dd5a40cbe1332333a213ac6f303d0554c2465
prerequisite-patch-id: 584c079fc06a3a4f0b21f7b56de953ad9c67aff7
prerequisite-patch-id: 19dc4584f58625c416a0d05e0c7b274e6d76ede0
prerequisite-patch-id: 917e153fa32a5a3e7f796a1e5e1ed54ddaffd383
prerequisite-patch-id: d5e8a1cf5d8ce8e553d02a64ee324909d7b74526
prerequisite-patch-id: 4539e3432ffbacc270660aeefa2b227d93d40dc2
prerequisite-patch-id: 869f0164b99a35b0226152810d228b96e12eb161
prerequisite-patch-id: 8e078129111c08e2641597a1f949b4dfd36f685d
prerequisite-patch-id: 53e2273be34a28885a28ff549ca07d8670e2f7db
prerequisite-patch-id: e0f183179eb5704a2c8a24e85db6f2af6622bd09
prerequisite-patch-id: 97358a34b86cf3d8fa7b0e4fab3162cb1bb12fd9
prerequisite-patch-id: 1c2e911a57eec3f60f8f30a01d69611e02a107cb
prerequisite-patch-id: 7d760019e7cd739b9885c5c4953bca7f6d05839e
prerequisite-patch-id: 04be2d889fa466f414b3ab098a29a8c11c9ffea4
prerequisite-patch-id: 03ae9e4833add51f0dcda8f0aed434db21596c0e
prerequisite-patch-id: bb42f43d5e677ae526a09d224a805b558993d5a4
prerequisite-patch-id: d80b4f58c33850c76ad7a9fd57037f79899976c2
prerequisite-patch-id: a9e8365b9183382cfff4ba7e873d3c84b6f3002d
prerequisite-patch-id: 03b962eca8161f9585f15d09b02baabb156a0a82
prerequisite-patch-id: 823eee7fb38bc0b8c3ce6b7785ecff3351c02462
prerequisite-patch-id: 07fbf3dd9583e9b67ed2c6ca6350a916fc509fb1
prerequisite-patch-id: f9d3aa0f7c8a00c544dc501300ea56889e3fe336
prerequisite-patch-id: 4e3135a0796429b863e96c026e57fa0745879a62
prerequisite-patch-id: 06eba32c522fbcf1b4b6568d7ad65fb6cfbbd96f
prerequisite-patch-id: cecf14467f62de74c2b7c8a974607fd929d4ba6d
prerequisite-patch-id: 6d08ce52c12c70d3f5410c2cc211a3adc5df68ea
prerequisite-patch-id: 64a707942d6235ad1bbc1d8f4f7309159d49efe2
prerequisite-patch-id: d0e1f11d79b80b4fcb2d1e4ac9024cd55ca67637
prerequisite-patch-id: 2e8bb13a23560d1c649ae8cff764c8181d6c585b
prerequisite-patch-id: 27551cf469fae44fd3c4e533124a35955ec16f48
prerequisite-patch-id: 2c53c35fbf777eefa9d866fab67512cd5eaf5e37
prerequisite-patch-id: 78dadcf62f46dd0b68d12e4a548aca5b31cce6cd
prerequisite-patch-id: 1ebb626d58e8c6e92279409a58f1000a24e8187b
prerequisite-patch-id: 450a555e6cfd996bc3044c565f614eb8c5eb80c4
prerequisite-patch-id: c2131d560c6d2f78a74f08d876188308faf146bf
prerequisite-patch-id: 4d2e60706d4c3d49bb04e71081440203b64e52b0
prerequisite-patch-id: c29c844583533905f649795a14e631816b6649f8
prerequisite-patch-id: 9fbe119faee0052c248c1fa449b061a4ff818e8a
prerequisite-patch-id: 276126fbdb98b02fec6afc34f72bdd2acd68ad7d
prerequisite-patch-id: 164652e88dcae476396fae958a822c4f3a5613b6
prerequisite-patch-id: 87d94bd2e2c752c26c6b11c61d64cea737e08b38
prerequisite-patch-id: e19b5076fa211ad2fa950a21088857051216ce32
prerequisite-patch-id: 671d3d8e4b272b5564280db66c6af33e38b249bf
prerequisite-patch-id: 0227d6030cc3dd66ef2ebf940c1f0f747e65dd9d
prerequisite-patch-id: 732d36e42c161025d4de1592decfdfeace69a65b
prerequisite-patch-id: 1d49368163386d507fa5dc3e89a272c3118824ec
prerequisite-patch-id: 491bb6e62499c3dd0ed4248c62bad3e8979a4843
prerequisite-patch-id: afe1b7d2c900dfbbb1149e5b70b24d4e1981de89
prerequisite-patch-id: cdfa0d42a305a2f27c7bcb07e988b4282de5b3f8
prerequisite-patch-id: a78db1ee67f5c52edbb67e219116e584c71e8dea
prerequisite-patch-id: 69bf16db7f0c34a472486b8146c897c9d37e2354
prerequisite-patch-id: 892132cdaa7b33213bdb124aa4c0ce7226f9c933
prerequisite-patch-id: 031f4e68e86b64ac198b433143b34ed8e1b36a2e
prerequisite-patch-id: 387f5a52c0e04649d0784d1ab778c4636136218f
prerequisite-patch-id: 38cb8b3495b7c96aee4db4105cb60ed69807283a
prerequisite-patch-id: 5ddd72a4f9704fbcec9a6df3072f388e8ec19add
prerequisite-patch-id: 6d1b3ba26a954f155a7f867b3d74a6d25947d4a3
prerequisite-patch-id: 4da977ad4b3c2bd1155af70fd3318120ffc33e7c
prerequisite-patch-id: 7e7e22dd3448ca9085ad81c580dbec0d8b1aa496
prerequisite-patch-id: 82f247ef1284e4ebc03facaffe454e5400895d58
prerequisite-patch-id: 321d5ba812a5d2e2821b9afb96a5b3afc6b35082
prerequisite-patch-id: ae61c8645b047697e0166d2f73e9983397c28e5b
prerequisite-patch-id: b14bcfa1856f18fb6b23002b8b43bb31268dba79
prerequisite-patch-id: df590935630616e0775959e50bab45ac8176a51a
prerequisite-patch-id: 5ee2c6363a79880b1b474741c736a657b64c3e30
prerequisite-patch-id: dd0c62481a5f5a3ef73cf844f0cbca0947d43026
prerequisite-patch-id: 9acbb3ec5c33c6d3dd9ec8bce148966d1c4c07f8
prerequisite-patch-id: cf96dcca8ad704583c2b00205197a5096799f809
prerequisite-patch-id: 513d44845743120511e5700208fcd61e8b0a9c4b
prerequisite-patch-id: 598861ab70a52a5217d1ad4450837b528fb05f16
prerequisite-patch-id: 581237d23101184c4923f25081913c2e3f52a92f
prerequisite-patch-id: 68fa6bb52f4944af2b7cbdf106f0365108b9d019
prerequisite-patch-id: 14ac750f0743ca403de15c6fe5647d716b199f43
prerequisite-patch-id: 0d0c827dc03bbfd4e5032c8c3b3fd665243753be
prerequisite-patch-id: fa6e47e8d2aecb5550165f44fb8aefc3053a2240
prerequisite-patch-id: 764a62804dc0bcac320ad05e466ec4b07113a9e4
prerequisite-patch-id: 6ef91f0837fbf1e87004c6970d2aba1c7a7bbd22
prerequisite-patch-id: ba0d12a6b956ab3b9de9967c501fde3b572e52c1
prerequisite-patch-id: 4b117cfaddc81bd773c90205936d9cd095fc61dd
prerequisite-patch-id: b513ceff1c32aae46ee65d31306b700620d52812
prerequisite-patch-id: 0c7cbd97f62e11024e6c2d1b42cd84abc1c56bf9
prerequisite-patch-id: a12fcf7da8dd5c188004c40cf9e8bd7f88766409
prerequisite-patch-id: 7279cb66eb0adc348e6cf33f62b60ded01673241
prerequisite-patch-id: 35532d41a6f25cbc81e08b81351a064e109a7929
prerequisite-patch-id: 13003d4ff68f7593d9f09b1841be4eb5d9213c3c
prerequisite-patch-id: 708d680203aefb63e489982a1f34e30de14abaf6
prerequisite-patch-id: f1848f4fe69814ac15707d7c6caf8e447b50e512
prerequisite-patch-id: 786d5d3bb21ece31dbe800830bfe18509ab218e5
prerequisite-patch-id: 99956115402d9ae9552da1d5350ac05e850c8cf2
prerequisite-patch-id: 0c31fe1bedc4f4e130f14ff5fef47d3a786bafaf
prerequisite-patch-id: 1594888c870e9108f969aa068dc53a922d9abb9e
prerequisite-patch-id: 90521c92a58cb5662a18a126bd80df09811708fd
prerequisite-patch-id: 1aab04b4aa912c8194eb0e5ac1955cce9c265b23
prerequisite-patch-id: cb61e2d87ac480b42dde616d67f4789ef14e2563
prerequisite-patch-id: 9a8954c818f85b78adf346fa1ae5a96998526d12
prerequisite-patch-id: ee631478d799fa0d5c861550c849e3058ff72d08
prerequisite-patch-id: 8109f84818154c8b9ba5f19db5e91ef8e26224a9
prerequisite-patch-id: d4080565fd7f54b25c17df284b6749b92a36787e
prerequisite-patch-id: 64b7803b5453bdd2ada5f2918901ad092e4ea1cf
prerequisite-patch-id: 6aecc3f1db1cd342e3b204310464179ca66b52ba
prerequisite-patch-id: 10e3a79796f2966733349c4cfcc1a61a49bc20af
prerequisite-patch-id: 5ddc3c20a99f60bddb62d58eb192facf0eb25b75

Best regards,
-- 
Vincent Mailhol <mailhol@kernel.org>


