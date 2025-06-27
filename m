Return-Path: <linux-can+bounces-3910-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91429AEB091
	for <lists+linux-can@lfdr.de>; Fri, 27 Jun 2025 09:51:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EF8E1C2375E
	for <lists+linux-can@lfdr.de>; Fri, 27 Jun 2025 07:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF3AE22541B;
	Fri, 27 Jun 2025 07:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=growora.pl header.i=@growora.pl header.b="fAll9Oao"
X-Original-To: linux-can@vger.kernel.org
Received: from mail.growora.pl (mail.growora.pl [51.254.119.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073AF194098
	for <linux-can@vger.kernel.org>; Fri, 27 Jun 2025 07:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.254.119.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751010708; cv=none; b=HutM0kqkfHZziIhxQNHsxQrnan0tnSg9ckIpURGrJwog8O/B9XbKaCnQeLrf+XskERxA78pmLmeOtFSXXKgHg486MI0pMxaBqvS01PfSx2GYrk1FBbbBgxO1GhASWjIs76Ae4vMQXi3XBMp33tcCyyKYxMpKtMu7Kxb0uEs1AVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751010708; c=relaxed/simple;
	bh=EB99enkNQ3/lKc2PdUObvM5/Gi3NF8gZrWwaTOp5KYs=;
	h=Message-ID:Date:From:To:Subject:MIME-Version:Content-Type; b=B+hNz6llCDJgA/aoCMrwWZ35F3RbLgMFA/Sc+ua0qNP70pq6jan5Toa7BK7zzynxT61dCY05u/ayzDoYfPyuDTJ0fo2D4VNsYGZEMX0sQEm9qG+SmbliO+xt7z8F1ghiHYihXSUmNh0E1sajXt6hhwh0Bz85C3bulttsXQR5VLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=growora.pl; spf=pass smtp.mailfrom=growora.pl; dkim=pass (2048-bit key) header.d=growora.pl header.i=@growora.pl header.b=fAll9Oao; arc=none smtp.client-ip=51.254.119.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=growora.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=growora.pl
Received: by mail.growora.pl (Postfix, from userid 1002)
	id 9D09123B8E; Fri, 27 Jun 2025 09:51:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=growora.pl; s=mail;
	t=1751010705; bh=EB99enkNQ3/lKc2PdUObvM5/Gi3NF8gZrWwaTOp5KYs=;
	h=Date:From:To:Subject:From;
	b=fAll9OaoJH0R4Up94QzTJZie7ClntuCw8dVlJedDE4TjFRq4UxxRItAAJyvKzq+Ts
	 v4FgPUIstddXYd22WkPPqQFgxSyF7ri0yJoHHKheUFszu7KJ2Vm7eoq0KiZZwQQcvb
	 flWGzn/ZsO3NtgkWhPgLE/wXBVIfLXdePKfo0+biStI+nQUXjDiQ5zZc9f1KWU7AZo
	 e/yZBER4IylGHW8AjX3Lam4HdKBdvSACToylk28PZWl5bFlI50D7MqXo+2edMnQwYX
	 NHhTKgrZLfx3ihzVLrNJ3AwKEB255uDsm5/bYLpPsG/OBhD325GQyJiXv7vso+dHKe
	 CtD/PeAuk8c6w==
Received: by mail.growora.pl for <linux-can@vger.kernel.org>; Fri, 27 Jun 2025 07:50:50 GMT
Message-ID: <20250627084500-0.1.ka.21l1g.0.o3sex09hq2@growora.pl>
Date: Fri, 27 Jun 2025 07:50:50 GMT
From: "Mateusz Hopczak" <mateusz.hopczak@growora.pl>
To: <linux-can@vger.kernel.org>
Subject: IT bez rekrutacji
X-Mailer: mail.growora.pl
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Cze=C5=9B=C4=87,

wiem, =C5=BCe rozw=C3=B3j oprogramowania to dzi=C5=9B nie tylko kwestia t=
echnologii, ale tempa i dost=C4=99pno=C5=9Bci odpowiednich ludzi.=20

Je=C5=9Bli temat dotyczy r=C3=B3wnie=C5=BC Pa=C5=84stwa zespo=C5=82u, by=C4=
=87 mo=C5=BCe warto porozmawia=C4=87 o wsp=C3=B3=C5=82pracy, w kt=C3=B3re=
j to my przejmujemy ca=C5=82y proces tworzenia oprogramowania =E2=80=93 o=
d analizy po utrzymanie. Pracujemy elastycznie, dostosowuj=C4=85c si=C4=99=
 do wewn=C4=99trznych procedur i Waszego stacku technologicznego.

Dzia=C5=82amy tak, jakby=C5=9Bmy byli cz=C4=99=C5=9Bci=C4=85 zespo=C5=82u=
, ale bez operacyjnego ci=C4=99=C5=BCaru, ryzyka kosztownych rekrutacji, =
z elastycznym podej=C5=9Bciem i transparentnym modelem rozlicze=C5=84.

Czy jeste=C5=9Bcie Pa=C5=84stwo zainteresowani pog=C5=82=C4=99bieniem tem=
atu?


Pozdrawiam
Mateusz Hopczak

