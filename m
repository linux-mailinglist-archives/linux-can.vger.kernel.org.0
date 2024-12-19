Return-Path: <linux-can+bounces-2454-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A4779F7262
	for <lists+linux-can@lfdr.de>; Thu, 19 Dec 2024 03:01:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C238916E1AD
	for <lists+linux-can@lfdr.de>; Thu, 19 Dec 2024 01:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 767B14D8DA;
	Thu, 19 Dec 2024 01:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xqfvh8Ra"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AED34C81;
	Thu, 19 Dec 2024 01:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734573265; cv=none; b=oNjabg2n3JtgT7oDP/AOVhSDOrdA9agqlekSFl4KhcxX1Zlaw4ZodUpl87Dc/k+DsWBzm6pdIwZ9JffAMMSEbNdnSGdx68zxPHP58ARfHnav8qitjRbxfs1rwMdx+uUxTNJS0ZOOtUoT1JkA/WchkgMVd5R+1uQPM1bGeC0oUgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734573265; c=relaxed/simple;
	bh=citZZ5/1BTb9kiBfOZkokVSIeJCXtqNY6giPUNTAVBI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rP5gNTql7vUpdeG6DCsc0PfUQWblaiblCE3aHtFOB5gBzphURcCtqyUVlQJ1z9r4osFHD15RmdUTm9v/1SLpSfILNyPSEM8cJx0ev0RSG+GuNr8uRDUHmczSQfl0IGH/TuIN5T0bSXNWthF2tpwTu0uMP6QA9hf1MZQUVEBVj8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xqfvh8Ra; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7B8CC4CECD;
	Thu, 19 Dec 2024 01:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734573264;
	bh=citZZ5/1BTb9kiBfOZkokVSIeJCXtqNY6giPUNTAVBI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Xqfvh8RaUG0x3vtzA5SfNub93da0eFFSg0dEVz+nxeYYk0CUz3twHcfMqukBIsP6P
	 HLKYLfc3lFBvgXNQ7TunOKhvqR7GXzpuMZA6iTDpPODbFolLlrQF+vf4nm3D4yTpIP
	 F8WTP2HLjsGXcp9E7wPWcwEUIlDNKSm13E8vxufGhHxGdoq6QJHa4zb+B5+7d3dcjs
	 fRWQj8icwBmaJBgOec8MXiX/rPPgPtzY+oDGo6HujmXPa/+eCWp4o3ja3NnR8xyZwZ
	 u7JNUmZNYEvs7YP5j7LG303YPRhOi4w/fVGbViw73HKsETV6Stxs5BnIXv5kFBj9Bv
	 95edwWJ/vINyQ==
Date: Wed, 18 Dec 2024 17:54:23 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, linux-can@vger.kernel.org,
 kernel@pengutronix.de
Subject: Re: [PATCH net 0/2] pull-request: can 2024-12-18
Message-ID: <20241218175423.20cd97b1@kernel.org>
In-Reply-To: <20241218121722.2311963-1-mkl@pengutronix.de>
References: <20241218121722.2311963-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 18 Dec 2024 13:10:26 +0100 Marc Kleine-Budde wrote:
> this is a pull request of 21 patches for net/master.

The "21" is just quantum state of 1 becoming 2? ;)

