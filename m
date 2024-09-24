Return-Path: <linux-can+bounces-1557-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC6BA984A8D
	for <lists+linux-can@lfdr.de>; Tue, 24 Sep 2024 20:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85AAC1F24942
	for <lists+linux-can@lfdr.de>; Tue, 24 Sep 2024 18:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 461EF1ABEDC;
	Tue, 24 Sep 2024 18:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aAqnMEyE"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1258D31A60;
	Tue, 24 Sep 2024 18:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727200868; cv=none; b=EyeZIhK4NqS92uUTsVTuP2dKkyR7ca3xGYxuvyhoU5AsohURpLqvN9TxcBXgzA7Iv/YNR3NCHgeM6n5CByefhk8HkDFQhP+i0JNivoYAK/TYsdUkJkYzapTubJj4SyxGTDYfG//5EWMT6oIscT/50yVNEA+Iaa7M8B/+RR3VqNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727200868; c=relaxed/simple;
	bh=vE8pGVYwDVIrlIjKoF6T0212mB8n6SPYkRCwr61rAUw=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=BAY9QLHtdYuwqujfw9HqYsL/l8tX/hn2/AKW+86iABT5m/PERZwIGIzxyXZPJjg+kkvhyX9JXDsRqE58UzqQIkRrLe+7lCJyrFEfXfKWcPUFaoYy9spmQ5t+o84v1FcszrpbtD5f32hF/ufQ9jmGtAFXVxOR3in8er+nDGdmD8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aAqnMEyE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92A3FC4CEC4;
	Tue, 24 Sep 2024 18:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727200866;
	bh=vE8pGVYwDVIrlIjKoF6T0212mB8n6SPYkRCwr61rAUw=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=aAqnMEyEu0uCAmz3kn+7IUO3/RB2QOyeS8oYiE9bDkCZXnPdlkSCkZxg53/BA8NXm
	 9iI/dz08QotnMxwXZY53r0cEaGM3YM/FX1UQmPw0A0yQjOWL7InId3K4E2Kz+cLfil
	 Zae2E9R+y0ofIaIoU3xQPPgxCvTOQJ1TGYP8YBCjp2SGn/8we61MDb70v7KqJW6v0h
	 5012T6eLvZ3ZgjKXNyCVjCEpGAYqkEOSWHZuqtirKTDf6Hm8Y7PNO3UJsIqKyBPc9W
	 jTzOKtSstllbY5a7lhpC2Jv5v4v9UFtEKJwcnrI4JDo17ek7KkPsJJ2PI7UosP0fho
	 CIO2/qMpUxs9Q==
Date: Tue, 24 Sep 2024 13:01:05 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Hal Feng <hal.feng@starfivetech.com>
Cc: "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, 
 William Qiu <william.qiu@starfivetech.com>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Emil Renner Berthing <emil.renner.berthing@canonical.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 netdev@vger.kernel.org, linux-can@vger.kernel.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>
In-Reply-To: <20240922145151.130999-3-hal.feng@starfivetech.com>
References: <20240922145151.130999-1-hal.feng@starfivetech.com>
 <20240922145151.130999-3-hal.feng@starfivetech.com>
Message-Id: <172720086189.2892.16772874968651869906.robh@kernel.org>
Subject: Re: [PATCH v2 2/4] dt-bindings: can: Add CAST CAN Bus Controller


On Sun, 22 Sep 2024 22:51:48 +0800, Hal Feng wrote:
> From: William Qiu <william.qiu@starfivetech.com>
> 
> Add bindings for CAST CAN Bus Controller.
> 
> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> ---
>  .../bindings/net/can/cast,can-ctrl.yaml       | 106 ++++++++++++++++++
>  1 file changed, 106 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/can/cast,can-ctrl.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/net/can/cast,can-ctrl.yaml:27:9: [warning] wrong indentation: expected 10 but found 8 (indentation)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240922145151.130999-3-hal.feng@starfivetech.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


