Return-Path: <linux-can+bounces-1171-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD2694B059
	for <lists+linux-can@lfdr.de>; Wed,  7 Aug 2024 21:13:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EE7E284F20
	for <lists+linux-can@lfdr.de>; Wed,  7 Aug 2024 19:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF0514430A;
	Wed,  7 Aug 2024 19:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Blu8wwhl"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C191419B5;
	Wed,  7 Aug 2024 19:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723057962; cv=none; b=H74lo3G9qcJhCjyEexuGdtWdhcLE4yZVJEA37IOSHikobadCrgXqYZOALGNDkPMegk3RVQB6+GGqalb1AM6KUXsCQN3kA1vxQ1gJgS71KFAh8TXSJSM5LbOa+Nn5zAsHWb5RxgvqB6F0+2EkBo0XOdUqgDB0m2txNEjBQnuc09M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723057962; c=relaxed/simple;
	bh=igA/R1dhPYSPH3SJW/wKLLEHcSURTRCtuSc+w8fGXoU=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=S+suequwdNAQZbM0DBzH5RgD0usgUHjjDpfY49uOJ6aC7nNiL9n7MkjZCHuEw2ghfdWb3qDwALANpysnB8qRBaGJPVYZ2kR4F27CGgzXgioX6/K3j7/S/dWpP5vyPlRI0giRv9I2aJt9M+Rdg82DrnvIXbRtTRsZXgey9bOzPyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Blu8wwhl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC74EC32781;
	Wed,  7 Aug 2024 19:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723057962;
	bh=igA/R1dhPYSPH3SJW/wKLLEHcSURTRCtuSc+w8fGXoU=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=Blu8wwhls32sv5GkAteiD2Vn7Z48ZLthiIyrkpJkW5QliaI/pS+0SpzrTYQT0RdhG
	 AxmnJv/1CGV+XfeQh5YXJtaE73mRaOrIGedX27UMqQOmcWLujzAFeUltkdRIN+Q5l4
	 KynYiceG1JogP7DcpfG3g7AlNJnKywQbvMmSmXaWRnIhPsCpBmXdhG+tqUm4UNIsY9
	 unr81+6FskrsIYFOhmscG+NGmi+CuHc5YsN0jOluGcJBAI6lX+RorkyVHXzw2NLD02
	 FtN3ddFmGOhtrnIHPtVVJB0stzNXPNk1H+WeqAWCdus73TM9RYMd2fIIJ5oWH2fiqX
	 ng0IqHkaCfY5A==
Date: Wed, 07 Aug 2024 13:12:40 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Ilya Orazov <ilordash02@gmail.com>
Cc: Conor Dooley <conor+dt@kernel.org>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Vinod Koul <vkoul@kernel.org>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Aswath Govindraju <a-govindraju@ti.com>, linux-phy@lists.infradead.org, 
 devicetree@vger.kernel.org, Kishon Vijay Abraham I <kishon@kernel.org>, 
 linux-can@vger.kernel.org
In-Reply-To: <20240807180956.1341332-2-ilordash02@gmail.com>
References: <20240807180210.1334724-2-ilordash02@gmail.com>
 <20240807180956.1341332-1-ilordash02@gmail.com>
 <20240807180956.1341332-2-ilordash02@gmail.com>
Message-Id: <172305796084.3042321.10920811109606243151.robh@kernel.org>
Subject: Re: [PATCH v2 1/1] dt-bindings: phy: ti,tcan104x-can: Document
 Microchip ATA6561


On Wed, 07 Aug 2024 21:09:56 +0300, Ilya Orazov wrote:
> Microchip ATA6561 is High-Speed CAN Transceiver with Standby Mode.
> It is pin-compatible with TI TCAN1042 and has a compatible programming
> model, therefore use ti,tcan1042 as fallback compatible.
> 
> Signed-off-by: Ilya Orazov <ilordash02@gmail.com>
> ---
>  .../devicetree/bindings/phy/ti,tcan104x-can.yaml    | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml:19:9: [warning] wrong indentation: expected 10 but found 8 (indentation)
./Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml:20:11: [warning] wrong indentation: expected 12 but found 10 (indentation)
./Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml:24:11: [error] duplication of key "const" in mapping (key-duplicates)
./Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml:25:11: [error] duplication of key "const" in mapping (key-duplicates)

dtschema/dtc warnings/errors:
make[2]: *** Deleting file 'Documentation/devicetree/bindings/phy/ti,tcan104x-can.example.dts'
Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml:24:11: found duplicate key "const" with value "ti,tcan1043" (original value: "ti,tcan1042")
make[2]: *** [Documentation/devicetree/bindings/Makefile:26: Documentation/devicetree/bindings/phy/ti,tcan104x-can.example.dts] Error 1
make[2]: *** Waiting for unfinished jobs....
./Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml:24:11: found duplicate key "const" with value "ti,tcan1043" (original value: "ti,tcan1042")
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml: ignoring, error parsing file
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1430: dt_binding_check] Error 2
make: *** [Makefile:240: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240807180956.1341332-2-ilordash02@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


